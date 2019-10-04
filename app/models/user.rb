class User < ApplicationRecord
  has_many :cravings
  has_many :bookings, as: :user1
  has_many :bookings, as: :user2
end
