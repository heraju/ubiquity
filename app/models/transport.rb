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
  
  def self.get_nearest_ones(user_id)
    user_location = self.find_by_user_id(user_id)
    lat = user_location.lat
    long = user_location.long
    
    result = Transport.find_by_sql("SELECT *, 3956 * 2 * ASIN(SQRT( POWER(SIN((#{lat} - abs(dest.lat)) * pi()/180 / 2),2) + COS(#{long} * pi()/180 ) * COS(abs(dest.lat) *  pi()/180) * POWER(SIN((#{long} - dest.long) *  pi()/180 / 2), 2) )) as distance FROM transports dest having distance < 5 ORDER BY distance limit 10")
    user_loc_hash = result.map{|r| [r.lat,r.long]}
    return user_loc_hash
  end
end
