module CommonFunctions

  # generate pdf report for CV
  def CommonFunctions.generate_pdf(cv)
    dark_green = '003900'
    light_gray = 'f0f0f0'
    delimiter = Proc.new { |d|
      d.move_down 12
      d.stroke do
        # d.stroke_color dark_green
        d.stroke_gradient [0, d.cursor], [d.bounds.right, d.cursor], dark_green, light_gray
        d.line_width 0.5
        d.horizontal_rule
      end
      if d.cursor < 80
        d.start_new_page
      else
        d.move_down 12
      end
    }

    pdf_part_from_hash = Proc.new { |d, cv_tran, prop_name|
      if cv_tran[prop_name].present?
        d.text I18n.t("cv.show.#{prop_name.to_s}").upcase, size: 11, style: :bold, color: dark_green
        d.move_down 8
        cv_tran[prop_name].each do |k, v|
          d.text_box '•', at: [13, d.cursor]
          d.indent(30) do
            d.text k.capitalize + ': ' + v, align: :justify
          end
        end
        delimiter.call(d)
      end
    }

    pdf_part_from_string = Proc.new { |d, cv_tran, prop_name|
      if cv_tran[prop_name].present?
        d.text I18n.t("cv.show.#{prop_name.to_s}").upcase, size: 11, style: :bold, color: dark_green
        d.move_down 8
        d.text cv_tran[prop_name], align: :justify
        delimiter.call(d)
      end
    }

    Prawn::Document.new do
      fonts = {}
      {normal: 'Regular', bold: 'Bold', italic: 'Italic', bold_italic: 'BoldItalic'}.each do |k, v|
        fonts[k] = "#{Rails.root.to_s}/app/assets/fonts/AnonymousPro#{v}/AnonymousPro#{v}.ttf"
      end
      default_leading 3
      font_families.update('AnonymousPro' => fonts )
      font 'AnonymousPro', size: 11

      # Header
      text cv.cv_trans[0].full_name, size: 18, style: :bold, align: :center, color: dark_green
      move_down 8
      text cv.cv_trans[0].position, align: :center
      delimiter.call(self)
      icon "<icon size='9'>fa-home</icon> #{cv.cv_trans[0].address} | <icon size='9'>fa-phone</icon> #{cv.phone} | <icon size='9'>fa-envelope-o</icon> #{cv.email} | <icon size='9'>fa-skype</icon> #{cv.skype}", inline_format: true, size: 9, align: :center
      delimiter.call(self)

      # Summary
      pdf_part_from_string.call(self, cv.cv_trans[0], :summary)

      # Personal skills
      pdf_part_from_string.call(self, cv.cv_trans[0], :personal_skills)

      # Technical skills
      pdf_part_from_hash.call(self, cv.cv_trans[0], :technical_skills)

      # Qualification
      if cv.cv_trans[0].qualification.present?
        text I18n.t('cv.show.qualification').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        cv.cv_trans[0].qualification.each do |v|
          text_box '•', at: [13, cursor]
          indent(30) do
            text v, align: :justify
          end
        end
        delimiter.call(self)
      end

      # Experiences
      if cv.cv_trans[0].experiences.present?
        text I18n.t('cv.show.experiences').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        cv.cv_trans[0].experiences.sort_by(&:started_at).reverse.each do |exs|
          text_box "#{I18n.l(exs.started_at.to_date)} — #{(exs.finished_at.nil? ? 'Now' : I18n.l(exs.finished_at.to_date))}", at: [0, cursor]
          indent(160) do
            text exs.position, align: :justify, style: :bold
            text "<b>#{exs.company}</b>#{exs.company_site ? ' (' + exs.company_site + ')' : ''}#{exs.company_address.present? ? ' — ' + exs.company_address : ''}", align: :justify, inline_format: true

            # Duties
            if exs.duties.present?
              text I18n.t('cv.show.duties'), size: 11, style: :bold, color: dark_green
              exs.duties.each do |v|
                text_box '•', at: [13, cursor]
                indent(30) do
                  text v, align: :justify
                end
              end
            end

            # Projects
            if exs.projects.present?
              text I18n.t('cv.show.projects'), size: 11, style: :bold, color: dark_green
              exs.projects.sort_by(&:id).each do |prj|
                text_box '•', at: [13, cursor]
                indent(30) do
                  text prj.name + (prj.link.present? ? ' (' + prj.link + ')' : ''), align: :justify
                  text prj.description, align: :justify, size: 9 if prj.description.present?
                  text prj.technologies, align: :justify, size: 9 if prj.technologies.present?
                end
              end
            end

          end
        end
        delimiter.call(self)
      end

      # Educations
      if cv.cv_trans[0].educations.present?
        text I18n.t('cv.show.educations').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        cv.cv_trans[0].educations.sort_by(&:year).reverse.each do |edn|
          text_box edn.year.to_s, at: [0, cursor]
          indent(40) do
            text "<b>#{edn.degree + (edn.specialty ? ': ' : '')}</b>#{edn.specialty}", align: :justify, inline_format: true
            text edn.institution + (edn.institution_address.nil? ? '' : ' - ' + edn.institution_address), align: :justify
          end
        end
        delimiter.call(self)
      end

      # Links
      pdf_part_from_hash.call(self, cv.cv_trans[0], :links)

      # Languages
      pdf_part_from_hash.call(self, cv.cv_trans[0], :languages)

    end.render
  end

  # import CV from xml file
  # update existed CV if token found, else - create new CV
  def CommonFunctions.import(file_name)
    p 'Import started'
    file_name ||= 'in.xml'
    # parse xml to hash
    doc = Nokogiri::XML(File.open(Rails.root.join('xml',file_name))) { |conf| conf.strict.noblanks }
    h = Hash.from_xml(doc.to_s.gsub(/\n\s+/,'').gsub(/\n/,''))
    h.deep_symbolize_keys!

    # update|insert CV from hash
    xcv = h[:cv]
    unless xcv.nil?
      xtoken = xcv[:token]
      cv = Cv.find_or_initialize_by(token: xtoken)
      set_attributes_from_hash(cv, xcv)
      p 'Main CV card imported'
      unless xcv[:cv_trans].nil?
        xcv_trans = xcv[:cv_trans][:cv_tran]
        xcv_trans.each do |xcv_tran|
          cv_tran = cv.cv_trans.find_or_initialize_by(tran_lang: xcv_tran[:tran_lang])
          set_attributes_from_hash(cv_tran, xcv_tran)

          # clear all child models
          cv_tran.educations.destroy_all
          cv_tran.experiences.destroy_all

          # add educations
          unless xcv_tran[:educations].nil?
            xeducations = xcv_tran[:educations][:education]
            xeducations.each { |xeducation| set_attributes_from_hash(cv_tran.educations.new, xeducation) }
          end

          # add experiences
          unless xcv_tran[:experiences].nil?
            xexperiences = xcv_tran[:experiences][:experience]
            xexperiences.each do |xexperience|
              experience = cv_tran.experiences.new
              set_attributes_from_hash(experience, xexperience)

              # add projects
              unless xexperience[:projects].nil?
                xprojects = xexperience[:projects][:project]
                xprojects.each { |xproject| set_attributes_from_hash(experience.projects.new, xproject) }
              end
            end
          end
          p "CV_details in lang '#{xcv_tran[:tran_lang]}' imported"
        end
      end
    end
    p cv.nil? ? 'An unknown error occurred during import' : "Import finished. Token: #{cv.token}"
  end

  private

  # set madel attributes from hash received from xml file
  def CommonFunctions.set_attributes_from_hash(model, hash)
    hash.keys.each do |k|
      if model.attribute_names.include?(k.to_s)
        if hash[k].is_a? Hash
          as_hash = {}
          as_arr = []
          hash[k].values[0].each do |val|
            if val.is_a? String
              as_arr << val
            elsif val.is_a? Hash
              as_hash[val[:key].to_sym] = val[:value]
            end
          end
          model[k] = as_arr.empty? ? as_hash : as_arr
        else
          model[k] = hash[k]
        end
      end
    end
    model.save
  end
end