class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :zip_code, presence: true, numericality: true
  
  has_many :cravings
  has_many :bookings, as: :user1
  has_many :bookings, as: :user2

end
