class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update!(user_params)
    render json: @user
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    # redirect_to users_url, status: 303
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
