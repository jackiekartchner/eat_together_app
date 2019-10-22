class Api::UsersController < ApplicationController

#will not be needing a backend index, but wanted it here just for reference
  # def index
  #   @users = User.all
  #   render 'index.json.jb'
  # end

  def show
    @user = User.find(current_user.id)
    render 'show.json.jb'
  end

  def create
    user = User.new(
        full_name: params[:full_name],
        phone_number: params[:phone_number],
        email: params[:email],
        zip_code: params[:zip_code],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
    if user.save 
      render 'show.json.jb'
    else
      render json: {errors: user.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    @user.full_name = params[:full_name] || @user.full_name
    @user.phone_number = params[:phone_number] || @user.phone_number
    @user.email = params[:email] || @user.email
    @user.zip_code = params[:zip_code] || @user.zip_code
    @user.password = params[:password] || @user.password_digest

    if @user.save 
      render 'show.json.jb'
    else
      render json: {errors: @user.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: {message: "Successfully Destroyed User"}
  end
end



