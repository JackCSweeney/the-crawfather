class UserSleeperAccount < ApplicationRecord
  belongs_to :user
  validates :username, :sleeper_user_id, :user_id, presence: true
end