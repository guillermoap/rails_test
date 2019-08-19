class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :cors_set_access_control_headers

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def cors_preflight_check
    return unless request.method == 'OPTIONS'
    cors_set_access_control_headers
    render text: '', content_type: 'text/plain'
  end

  protected

  def cors_set_access_control_headers
    response_headers = response.headers
    response_headers['Access-Control-Allow-Origin'] = '*'
    response_headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response_headers['Access-Control-Allow-Headers'] =
      'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response_headers['Access-Control-Max-Age'] = '1728000'
  end

  def render_not_found(_exception = nil)
    render json: {}, status: 404
  end
end
