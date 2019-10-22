class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :zip_code, presence: true, numericality: true
  
  has_many :cravings

  def bookings
    booking = Booking.where("user1_id = ? OR user2_id = ?", id, id)
  end

end
