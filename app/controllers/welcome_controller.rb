class WelcomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to '/home'
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to "/home"
    else
      flash[:error] = "Error: Email or Password is incorrect"
      redirect_to '/'
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end