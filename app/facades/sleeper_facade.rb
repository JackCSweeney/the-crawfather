class SleeperFacade
  def self.get_sleeper_user_id(sleeper_username)
    SleeperService.get_sleeper_user_id(sleeper_username)
  end
end