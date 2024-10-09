class SleeperLeaguesController < ApplicationController
  def create
    user = User.find(session[:user_id])
    user_sleeper_account = UserSleeperAccount.get_id_and_create(session[:user_id], params[:sleeper_username])
    user_sleeper_league = UserSleeperLeague.get_league_and_create(session[:sleeper_league_id], session[:user_id])
    # user_sleeper_team_matchup
  end
end