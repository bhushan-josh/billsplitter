class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end
  
  def show
    p params
    @users = User.find(params[:id])
    render json: @users
  end

  def new
    @user = User.new
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: api_v1_user_path(@user)
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @users = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password)
  end

end
