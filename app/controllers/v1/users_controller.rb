# frozen_string_literal: true

module V1
  class UsersController < V1::BaseController
    def index
      @users = User.all
      render json: @users
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    def new
      @user = User.new
      render json: @user
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: user_path(@user)
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def edit
      @user = User.find(params[:id])
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
      @user = User.find(params[:id])
      @user.destroy
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :email, :password)
    end
  end
end
