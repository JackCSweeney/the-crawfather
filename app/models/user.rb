class User < ApplicationRecord
  validates :name, :email, :password, presence: true
  validates :credits, presence: true, numericality: true
  has_many :questions, dependent: :destroy
  has_secure_password
  enum roundup_status: ["enabled", "disabled"]
end