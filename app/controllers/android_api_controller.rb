class AndroidApiController < ApplicationController
  
  def android_connect_user
    resource = User.find_for_database_authentication(:email=>params[:email])
    if resource
      if resource.valid_password?(params[:password])
        render :text => "true"
      else
        render :text => "false"
      end
    else
      render :text => "false"
    end
  end
end
