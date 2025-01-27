class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @users = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def show
    @users = User.find(params[:id])
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to users_url, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password) # Add other permitted fields as needed
  end
end
