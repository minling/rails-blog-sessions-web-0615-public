class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?, :login_required

  before_action :login_required

private
  def login_required
    if !user_signed_in?
      redirect_to login_path, :notice => "Log in to edit or delete your Post"
    else
      if session[:user_id] != current_user.id
        redirect_to login_path, :notice => "Log in to edit or delete your Post"
      end
    end
  end

  def user_signed_in?
    # if session[:user_id]
    #   if @current_user = User.find(session[:user_id])
    #     true
    #   else 
    #     false
    #   end
    # else
    #   false
    # end
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end #memoization



end
