class ApplicationController < ActionController::API

  include Pundit

  include ActionController::HttpAuthentication::Token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def authenticate
    unless authenticate_with_http_token { |token, options| User.find_by(token: token) }
      render json: { error: 'Bad Token'}, status: 401
    end
  end

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

end
