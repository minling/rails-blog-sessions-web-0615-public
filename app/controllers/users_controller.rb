class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  skip_before_action :login_required, :only => [:create, :new]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id #assigned session so don't have to log in after signing up
      redirect_to root_path(@user), :notice => "Thank you for signing up!"
    else
      render :new
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
