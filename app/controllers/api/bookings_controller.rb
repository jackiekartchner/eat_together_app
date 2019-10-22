class Api::BookingsController < ApplicationController

  before_action :authenticate_user, only: [:destroy]

  # def index
  #   @bookings = current_user.bookings
  #   render 'index.json.jb'
  # end

  # def show
  #   @booking = Booking.find(params[:id])
  #   render 'show.json.jb'
  # end

  def destroy
    booking = Booking.find(params[:id])
    if current_user.id == booking.user1_id || current_user.id == booking.user2_id
    booking.destroy
    render json: {message: "Successfully deleted your booking!"}
    else
      render json: {message: "Unable to delete this user's booking."}
    end
  end
end


