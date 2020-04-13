class ApplicationController < ActionController::API
  include ResponseHelper
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    r = AuthorizeApiRequest.new(request.headers).call
    @current_user = r[:user]
  end
end
