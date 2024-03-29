class ApplicationController < ActionController::API

  include Pundit

  include ActionController::Serialization
  include ActionController::HttpAuthentication::Basic
  include ActionController::HttpAuthentication::Token
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { message: e.message }, status: 500
  end

  before_action :authenticate

  def current_user
    @current_user
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end

end
