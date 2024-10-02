class UserSleeperAccount < ApplicationRecord
  belongs_to :user
  validates :sleeper_username, :sleeper_user_id, :user_id, presence: true
end