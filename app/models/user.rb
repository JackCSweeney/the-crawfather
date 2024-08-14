class User < ApplicationRecord
  validates :name, :email, :roundup_status, :password, presence: true
  validates :credits, presence: true, numericality: true
  has_many :questions, dependent: :destroy
  has_secure_password
end