class WelcomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to '/home'
    end
  end
end