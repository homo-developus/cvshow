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
      format.pdf { send_data(CommonFunctions.generate_pdf(@cv), filename: "#{@cv.cv_trans[0].full_name + ' - ' + @cv.cv_trans[0].position}.pdf", type: 'application/pdf') }
    end
  end
end