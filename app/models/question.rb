class Question < ApplicationRecord
  validates :question, :response, :user_id, presence: true
  belongs_to :user
end