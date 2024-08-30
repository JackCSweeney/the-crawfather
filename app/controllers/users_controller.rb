class UsersController < ApplicationController
  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def dashboard
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "Account created"
      session[:user_id] = user.id 
      redirect_to "/home"
    else
      flash[:error] = "#{error_message(user.errors)}"
      redirect_to "/users/new"
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :roundup_status)
  end
end