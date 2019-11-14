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
      account_sid = 'ACeab03714346174626f6a236c9afb233a'
      auth_token = ENV["TWILIO_API_KEY"]
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      
      numbers_to_message = [booking.user1.phone_number, booking.user2.phone_number]
      numbers_to_message.each do |number|
      message = @client.messages.create(
        body: "Uh-oh! Looks like your booking at #{booking.restaurant[:name]} on #{booking.appointment} has been cancelled! If you are unsure as to why your booking was cancelled or you would like to schedule another booking please visit the Eat Togethr website. Thank you and have a nice day!",    
        from: '+17329032851',
        to: number
        )  

      puts message.sid
    end
      render json: {message: "Successfully deleted your booking!"}
    else
      render json: {message: "Unable to delete this user's booking."}
    end
  end
end




