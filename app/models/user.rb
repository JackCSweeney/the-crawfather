class User < ApplicationRecord
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
  validates :credits, presence: true, numericality: true
  has_many :questions, dependent: :destroy
  has_many :user_sleeper_accounts, dependent: :destroy
  has_many :user_sleeper_leagues, dependent: :destroy
  has_secure_password
  enum roundup_status: ["enabled", "disabled"]

  def recent_question?
    if self.questions.last
      self.questions.last.created_at >= 2.minutes.ago
    else
      false
    end
  end
end