class UserSleeperAccount < ApplicationRecord
  belongs_to :user
  validates :sleeper_username, :sleeper_user_id, :user_id, presence: true

  def self.get_sleeper_user_id(sleeper_username)
    SleeperFacade.get_sleeper_user_id(sleeper_username)
  end

  def self.get_id_and_create(sleeper_username, user_id)
    sleeper_user_id = get_sleeper_user_id(sleeper_username)
    UserSleeperAccount.create!({user_id: user_id, sleeper_username: sleeper_username, sleeper_user_id: sleeper_user_id})
  end
end