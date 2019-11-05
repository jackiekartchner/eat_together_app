class Api::UsersController < ApplicationController

  # before_action :authenticate_user, only: [:update, :destroy]

  def show
    @user = current_user
    render 'show.json.jb'
  end

  def create
    @user = User.new(
        full_name: params[:full_name],
        phone_number: params[:phone_number],
        email: params[:email],
        zip_code: params[:zip_code],
        bio: params[:bio],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
    if @user.save 
      render 'show.json.jb'
    else
      render json: {errors: @user.errors.full_messages},
      status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.id == @user.id
      @user.full_name = params[:full_name] || @user.full_name
      @user.phone_number = params[:phone_number] || @user.phone_number
      @user.email = params[:email] || @user.email
      @user.zip_code = params[:zip_code] || @user.zip_code
      @user.bio = params[:bio] || @user.bio
      if params[:password] 
        @user.password = params[:password] 
      end
      if @user.save 
        render 'show.json.jb'
      else
        render json: {message: "Invalid entry."}, status: :unprocessable_entity
      end
    else
      render json: {message: "Unathorized to update this user's account."}
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.destroy
      render json: {message: "Account successfully destroyed!"}
    else
      render json: {message: "Unauthorized to delete this account."}
    end
  end
end 



