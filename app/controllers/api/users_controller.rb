class Api::UsersController < ApplicationController

#will not be needing a backend index, but wanted it here just for reference
  def index
    @users = User.all
    render 'index.json.jb'
  end

  def show
    
  end
end
