class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:create]

  has_scope :deleted, :type => :boolean

  def index
    @users = apply_scopes(User).all
    authorize @users
    render json: @users
  end

  def show
    authorize @user
    render json: @user
  end

  def create
    authorize @user
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      render json: @user, status: 204
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
