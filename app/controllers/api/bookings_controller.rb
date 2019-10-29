class Api::BookingsController < ApplicationController

  before_action :authenticate_user, only: [:destroy]

  def index
    @bookings = Booking.all
    if current_user
      @bookings = Booking.where("user1_id = ? OR user2_id = ?",current_user.id, current_user.id)
      @bookings = @bookings.order(:id)
      render 'index.json.jb'
    else
      render json: {message: "Unathorized to show this user's bookings."}
    end 
  end

  def show
    @booking = Booking.find(params[:id])
    if current_user.id == @booking.user1_id || current_user.id == @booking.user2_id
      render 'show.json.jb'
    else
      render json: {message: "Unathorized to show this user's booking info."}
    end 
  end

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




