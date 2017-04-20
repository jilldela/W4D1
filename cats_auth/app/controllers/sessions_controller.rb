class SessionsController < ApplicationController

  before_action :signed_in?, only: [:new]

  def new
    # @user = User.new
    render :new
  end

  def create
    user_name, password = session_params.values
    log_in(user_name, password)
    redirect_to cats_url
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end


  private

  def signed_in?
    redirect_to cats_url if current_user
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
