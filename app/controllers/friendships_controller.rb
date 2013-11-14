class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = current_user.friendships

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  # def show
  #   @friendship = Friendship.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @friendship }
  #   end
  # end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @friendship = current_user.friendships.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/1/edit
  # def edit
  #   @friendship = Friendship.find(params[:id])
  # end

  # POST /friendships
  # POST /friendships.json


  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to root_url, notice: 'Added friend.' }
        format.json { render json: @friendship, status: :created, location: root_url }
      else
        format.html { redirect_to root_url, error: 'Unable to add friend.' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  # def update
  #   @friendship = Friendship.find(params[:id])

  #   respond_to do |format|
  #     if @friendship.update_attributes(params[:friendship])
  #       format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @friendship.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Removed friendship' }
      format.json { head :no_content }
    end
  end
end
