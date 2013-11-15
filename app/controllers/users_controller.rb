class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.where('id != :id', { id: current_user.id })
  end

  def show
    @user = current_user
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:notice] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def add_friend
    
  end

  def remove_friend
    
  end
end
