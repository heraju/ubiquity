class AndroidApiController < ApplicationController
  
  def android_connect_user
    resource = User.find_for_database_authentication(:email=>params[:email])
    if resource
      if resource.valid_password?(params[:password])
        render :json => {:response => true, :user_id => resource.id, :email => resource.email, :first_name => resource.first_name, :last_name => resource.last_name, :phone_number => resource.phone_number, :sos_number =>  resource.sos_number }
      else
        render :json => {:response => false}.to_json
      end
    else
      render :json => {:response => false}.to_json
    end
  end

  def android_create_trip
  	#http://www.cuputt.com/android_api/android_create_trip?userid=1&lat=12.96&long=77.56&type=1&number=500c
  	@transport = Transport.new
  	@transport.user_id = params['userid'].to_i
  	@transport.transport_type_id = params['type'].to_i
  	@transport.number = params['number']
  	@transport.lat = params['lat']
  	@transport.long = params['long']
  	@transport.session = "active"
  	if @transport.save
      render :json => {:response => true, :trip_id => @transport.id}.to_json 
    else
      render :json => {:response => false}.to_json
    end
  end

  def android_destroy_trip
  	#http://www.cuputt.com/android_api/android_destroy_trip?userid=1&tripid=1&lat=12.96&long=77.56
  	@transport = Transport.find(params["tripid"].to_i)
  	if @transport.update_attributes(:session => "close",:lat => params['lat'], :long => params['long'] )
        render :json => {:response => true}.to_json
    else
        render :json => {:response => false}.to_json
    end
  end

  def android_stream_geo
  	#http://www.cuputt.com/android_api/android_stream_geo?userid=1&tripid=1&lat=12.96&long=77.56
  	@transport = Transport.find(params["tripid"].to_i)
  	@transport.geo_locations << GeoLocation.create(:lat => params['lat'] , :long => params['long'])

  	if @transport.update_attributes(:lat => params['lat'], :long => params['long']) 
        render :json => {:response => true}.to_json
    else
        render :json => {:response => false}.to_json
    end
  	
  end	
  	
end
