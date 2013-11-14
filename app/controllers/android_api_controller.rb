class AndroidApiController < ApplicationController
  
  def android_connect_user
    resource = User.find_for_database_authentication(:email=>params[:email])
    if resource
      if resource.valid_password?(params[:password])
        render :text => "true,#{resource.id}, #{resource.email}, #{resource.first_name}, #{resource.last_name}"
      else
        render :text => "false"
      end
    else
      render :text => "false"
    end
  end
end
