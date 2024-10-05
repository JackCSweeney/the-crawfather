class UserSleeperLeague < ApplicationRecord
  validates :league_name, :sleeper_league_id, presence: true
  validates :sleeper_league_id, numericality: true
  belongs_to :user
end