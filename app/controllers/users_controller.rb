class UsersController < ApplicationController
  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
      @response = @user.questions.last.response if @user.recent_question?
    else
      flash[:error] = "You must be logged in to speak with The Crawfather"
      redirect_to root_path
    end
  end

  def dashboard
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
      flash[:error] = "You must be logged in to view your dashboard page"
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

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    user = User.find(session[:user_id])
    update_account(user)
    # require 'pry' ; binding.pry
    if user.save!(validate: false)
      redirect_to '/dashboard'
      flash[:success] = 'Account successfully updated'
    else
      flash[:error] = "Error: #{error_message(user.errors)}"
      redirect_to '/edit'
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :roundup_status)
  end

  def update_account(user)
    user.email = params[:email] if params[:email]
    user.name = params[:name] if params[:name]
  end
end