class Transport < ActiveRecord::Base
  attr_accessible :number, :session, :transport_type_id, :user_id ,:lat ,:long
  has_many :geo_locations, as: :locatable
  has_many :statuses, as: :statusable
  belongs_to :transport_type
  belongs_to :user

  after_create :create_geo_point

  def get_near_by_points(distanceInKM = '1')
    geo = $geoService.get_near_by_points_by_max_distance($geoStorageName, self.lat, self.long, distanceInKM)
    rescue Exception => e
      e.message
  end

  def all_near_by_points(resultLimit = '10')
    $geoService.get_near_by_point($geoStorageName, self.lat, self.long, resultLimit)
    rescue Exception => e  
      e.message
  end

  def create_geo_point
    geoPointsList = Array.new()  
    gp = App42::Geo::GeoPoint.new()  
    gp.lat = self.lat
    gp.lng = self.long
    gp.marker = self.id
    geoPointsList.push(gp)

    geo = $geoService.create_geo_points($geoStorageName, geoPointsList) 
  end

  def self.get_bus_information
    begin
      where(:session => "ACTIVE").map{|t| [t.lat,t.long,t.number]}
    rescue Exception => e
      return false
    end    
  end
end
