class Api::CravingsController < ApplicationController

  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    @cravings = Craving.all
    if current_user
      @cravings = Craving.where("user_id =?", current_user.id)
      @cravings = @cravings.order(:id)
      render 'index.json.jb'
    else
      render json: {message: "Unathorized to show this user's cravings."}
    end
  end

  def show
    @craving = Craving.find(params[:id])
    if current_user.id == @craving.user_id
      render 'show.json.jb'
    else 
      render json: {message: "Unathorized to show this user's craving info."}
    end
  end

  def create
    @craving = Craving.new(
        radius: params[:radius],
        category: params[:category],
        price: params[:price],
        user_id: current_user.id,
        appointment: params[:appointment],
      )
    if @craving.save  #logic to check for match
      if @craving.match
        #create new booking
        @booking = Booking.new(
            yelp_api_id: @craving.yelp_api_id,
            user1_id: @craving.user_id,
            user2_id: @craving.match.user_id,
            appointment: @craving.appointment
          )
        if @booking.save 
          render 'show.json.jb'
        else
          render json: {errors: @booking.errors.full_messages},
          status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @craving = Craving.find(params[:id])
    if current_user.id == @craving.user_id
      @craving.radius = params[:radius] || @craving.radius
      @craving.category = params[:category] || @craving.category
      @craving.price = params[:price] || @craving.price
      @craving.appointment = params[:appointment] || @craving.appointment
      if @craving.save  #logic to check for match
        if @craving.match
          #create new booking
          @booking = Booking.new(
              yelp_api_id: @craving.yelp_api_id,
              user1_id: @craving.user_id,
              user2_id: @craving.match.user_id,
              appointment: @craving.appointment
            )
          if @booking.save 
            render 'show.json.jb'
          else
            render json: {errors: @booking.errors.full_messages},
            status: :unprocessable_entity
          end
        end
      end
    end
  end
 

  def destroy
    craving = Craving.find(params[:id])
    if current_user.id == craving.user_id 
      craving.destroy
      render json: {message: "Successfully deleted your craving and associated booking!"}
    else
      render json: {message: "Unathorized to delete this user's craving and associated booking."}
    end
  end
end

