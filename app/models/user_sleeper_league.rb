class UserSleeperLeague < ApplicationRecord
  validates :sleeper_league_name, :sleeper_league_id, presence: true
  validates :sleeper_league_id, numericality: true
  belongs_to :user

  def self.get_league_and_create(sleeper_league_id, user_id)
    sleeper_league_name = get_sleeper_league_name(sleeper_league_id)
    UserSleeperLeague.create!({user_id: user_id, sleeper_league_name: sleeper_league_name, sleeper_league_id: sleeper_league_id})
  end

  def self.get_sleeper_league_name(sleeper_league_id)
    SleeperFacade.get_sleeper_league_name(sleeper_league_id)
  end
end