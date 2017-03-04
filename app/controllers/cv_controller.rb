class CvController < ApplicationController
  def show
    token = params[:token]
    @cv = Cv.includes(cv_trans: [{experiences: :projects}, :educations]).where(cv_trans: {tran_lang: @locale}).find_by_token(token)
  end
end
