class MyprofileController < ApplicationController
  def index
  end

  def edit
  	@user = current_user
  end	

  def update
	@user = User.find(current_user.id)
	  if @user.update_attributes(params[:user])
	    render :edit
	  else
	    render :edit
	  end
  end
  	
end
