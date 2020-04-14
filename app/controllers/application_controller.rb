class ApplicationController < ActionController::API
  include ResponseHelper
  include ExceptionHandler

  before_action :authorize_request, :set_locale
  attr_reader :current_user

  private

  def authorize_request
    r = AuthorizeApiRequest.new(request.headers).call
    @current_user = r[:user]
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    locale_param = params[:locale]
    I18n.locale_available?(locale_param) ? locale_param : nil
  end

end
