class WelcomeController < ApplicationController
  
  def index
    @lat_long_values=Transport.get_bus_information
  end

  def about 
  end
  
  def fetch_bus
    @lat_long_values=Transport.get_bus_information
    render :layout => false
  end
end
