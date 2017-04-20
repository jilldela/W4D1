class UsersController < ApplicationController

  before_action :signed_in?, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    user_name, password = user_params.values
    if @user.valid?
      @user.save
      log_in(user_name, password)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
    end
  end

  def show

  end

  def index

  end


  private
  def signed_in?
    redirect_to cats_url if current_user
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
