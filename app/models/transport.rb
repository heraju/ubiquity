class Transport < ActiveRecord::Base
  attr_accessible :number, :session, :transport_type_id, :user_id ,:lat ,:long
  has_many :geo_locations, as: :locatable
  has_many :statuses, as: :statusable
  belongs_to :transport_type
  belongs_to :user
  def self.get_bus_information
    begin
      where(:session => "ACTIVE").group(:number).map{|t| [t.lat,t.long,t.number]}
    rescue Exception => e
      return false
    end    
  end
end
