class SleeperFacade
  def self.get_sleeper_user_id(sleeper_username)
    SleeperService.get_sleeper_user_id(sleeper_username)
  end

  def self.get_sleeper_league_name(sleeper_league_id)
    SleeperService.get_sleeper_league_name(sleeper_league_id)
  end
end