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
  def my_travel_history
    @travel_history_list=current_user.transports.map{|t| [t.id,t.number,t.created_at]}
  end
  def build_history
    @start_point=current_user.transports.where(:id => params[:id]).first
    @end_point=current_user.transports.where(:id => params[:id]).last
  end
end
