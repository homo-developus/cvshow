class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  protected

  def set_locale
    @locale = params[:locale]
    if @locale.present? && CvTran.tran_langs.keys.include?(@locale)
      I18n.locale = @locale
    else
      render file: 'public/404.html', status: :not_found
    end
  end

end
