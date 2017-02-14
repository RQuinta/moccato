class SessionsController < ApplicationController

  before_action :set_user_session, only: [:create]
  skip_before_action :authenticate, only: [:create]

  def create
    if (@user.authenticate(session_params[:password]))
      render json: @user
    else
      render json: { error: 'Incorrect credentials' }, status: 401
    end
  end

  private

  def set_user_session
    @user = User.find_by(email: session_params[:email])
  end

  def session_params
    params.require(:session).permit([:email, :password])
  end

end