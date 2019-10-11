class Api::BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    if current_user
      @bookings = Booking.where("user1_id =? OR user2_id =?",current_user.id, current_user.id)
      @bookings = @bookings.order(:id)
      render 'index.json.jb'
  else
    render json: []
    end
  end

  def show
    @booking = Booking.find(params[:id])
    render 'show.json.jb'
  end

  def create
    @booking = Booking.new(
        yelp_api_id: params[:yelp_api_id],
        user1_id: params[:user1_id],
        user2_id: params[:user2_id],
        appointment: params[:appointment]
      )
    if @booking.save 
      render 'show.json.jb'
    else
      render json: {errors: @booking.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    render json: {message: "Successfully Destroyed Your Booking"}
  end
end
  # def update
  #   @booking = Booking.find(params[:id])
  #   @booking.yelp_api_id = params[:yelp_api_id] || @booking.yelp_api_id
  #   @booking.user1_id = params[:user1_id] || @booking.user1_id
  #   @booking.user2_id = params[:user2_id] || @booking.user2_id
  #   @booking.appointment = params[:appointment] || @booking.appointment

  #   if @booking.save 
  #     render 'show.json.jb'
  #   else
  #     render json: {errors: @booking.errors.full_messages},
  #     status: :unprocessable_entity
  #   end
  # end

