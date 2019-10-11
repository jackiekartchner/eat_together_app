class Api::CravingsController < ApplicationController
  def index
    @cravings = Craving.all
    if current_user
      @cravings = Craving.where("user_id =?", current_user.id)
      @cravings = @cravings.order(:id)
      render 'index.json.jb'
  else
    render json: []
    end
  end

  def show
    @craving = Craving.find(params[:id])
    render 'show.json.jb'
  end

  def create
    @craving = Craving.new(
        radius: params[:radius],
        category: params[:category],
        price: params[:price],
        user_id: params[:user_id],
        appointment: params[:appointment],
      )
    if @craving.save 
      render 'show.json.jb'
    else
      render json: {errors: @craving.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def update
    @craving = Craving.find(params[:id])
    @craving.radius = params[:radius] || @craving.radius
    @craving.category = params[:category] || @craving.category
    @craving.price = params[:price] || @craving.price
    @craving.user_id = params[:user_id] || @craving.user_id
    @craving.appointment = params[:appointment] || @craving.appointment

    if @craving.save 
      render 'show.json.jb'
    else
      render json: {errors: @craving.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def destroy
    craving = Craving.find(params[:id])
    craving.destroy
    render json: {message: "Successfully Destroyed Your Craving"}
  end
end
