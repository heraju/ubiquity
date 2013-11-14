class MyprofileController < ApplicationController
  def index
  end

  def edit
  	@user = current_user
  end	

  def update
	  @user = User.find(current_user.id)
	  if @user.update_attributes(params[:user])
      flash[:notice] = 'Account update successfully.'
	    render :edit
	  else
      flash[:error] = 'Something is not correct, please try again.'
	    render :edit
	  end
  end
  	
end
