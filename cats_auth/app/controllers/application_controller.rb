class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user_name, password)
    current_user = User.find_by_credentials(user_name, password)
    current_user.reset_session_token!
    session[:session_token] = current_user.session_token
  end
end
