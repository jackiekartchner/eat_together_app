class Api::CravingsController < ApplicationController

  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    @cravings = Craving.all
    if current_user
      @cravings = Craving.where("user_id =?", current_user.id)
      @cravings = @cravings.order(:updated_at => :desc)
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
    if @craving.save
    #logic to check for match
      if @craving.match
        #create new booking
        @booking = Booking.new(
            yelp_api_id: @craving.yelp_api_id,
            user1_id: @craving.user_id,
            user2_id: @craving.match.user_id,
            appointment: @craving.appointment
          )
        if @booking.save 
          # @craving.satisfied(@booking.user1_id, @booking.user2_id)
          #send message with Twilio
          account_sid = 'ACeab03714346174626f6a236c9afb233a'
          auth_token = ENV["TWILIO_API_KEY"]
          @client = Twilio::REST::Client.new(account_sid, auth_token)

          numbers_to_message = [@booking.user1.phone_number, @booking.user2.phone_number]
          numbers_to_message.each do |number|
          message = @client.messages.create(
            body: "Congratulations! A booking has been created for you via the Eat Together App! You will be eating at #{@booking.restaurant[:name]} on #{@booking.appointment}. You can go onto the Eat Together website for more details about your booking and your eating partner. Thank you and have an awesome day!",
            from: '+17329032851',
            to: number
            )  

          puts message.status
        end
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
      if @craving.save  
      #logic to check for match
        if @craving.match
          #create new booking
          @booking = Booking.new(
              yelp_api_id: @craving.yelp_api_id,
              user1_id: @craving.user_id,
              user2_id: @craving.match.user_id,
              appointment: @craving.appointment
            )
          if @booking.save 
            account_sid = 'ACeab03714346174626f6a236c9afb233a'
            auth_token = ENV["TWILIO_API_KEY"]
            @client = Twilio::REST::Client.new(account_sid, auth_token)

            numbers_to_message = [@booking.user1.phone_number, @booking.user2.phone_number]
            numbers_to_message.each do |number|
            message = @client.messages.create(
              body: "Congratulations! A booking has been created for you via the Eat Together App! You will be eating at #{@booking.restaurant[:name]} on #{@booking.appointment}. You can go onto the Eat Together website for more details about your booking and your eating partner. Thank you and have an awesome day!",
              from: '+17329032851',
              to: number
              )  

            puts message.status
          end
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

