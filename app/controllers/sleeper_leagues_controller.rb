class SleeperLeaguesController < ApplicationController
  def create
    require 'pry' ; binding.pry
    user_sleeper_account = UserSleeperAccount.get_id_and_create(session[:user_id], params[:sleeper_username])
    # user_sleeper_league 
  end
end