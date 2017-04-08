class CvController < ApplicationController
  def show
    token = params[:token]
    @cv = Cv.includes(cv_trans: [{experiences: :projects}, :educations]).where(cv_trans: {tran_lang: @locale}).find_by_token(token)
    respond_to do |format|
      format.html
      format.xml do
        @cv = Cv.includes(cv_trans: [{experiences: :projects}, :educations]).find_by_token(token)
        stream_xml = render_to_string(template: 'cv/show')
        send_data(stream_xml, filename: "#{@cv.cv_trans[0].full_name + ' - ' + @cv.cv_trans[0].position}.xml", type: 'text/xml')
      end
      format.pdf { send_data(generate_pdf(@cv), filename: "#{@cv.cv_trans[0].full_name + ' - ' + @cv.cv_trans[0].position}.pdf", type: 'application/pdf') }
    end
  end

  private

  def generate_pdf(cv)
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
      if cv.cv_trans[0].summary.present?
        text I18n.t('cv.show.summary').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        text cv.cv_trans[0].summary, align: :justify
        delimiter.call(self)
      end

      # Personal skills
      if cv.cv_trans[0].personal_skills.present?
        text I18n.t('cv.show.personal_skills').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        text cv.cv_trans[0].personal_skills, align: :justify
        delimiter.call(self)
      end

      # Technical skills
      if cv.cv_trans[0].technical_skills.present?
        text I18n.t('cv.show.technical_skills').upcase, size: 11, style: :bold, color: dark_green
        move_down 8
        cv.cv_trans[0].technical_skills.each do |k, v|
          text_box '•', at: [13, cursor]
          indent(30) do
            text k + ': ' + v, align: :justify
          end
        end
        delimiter.call(self)
      end

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

    end.render
  end


end
