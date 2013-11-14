class GeoLocation < ActiveRecord::Base
  attr_accessible :lat, :locatable_id, :locatable_type, :long, :state
  belongs_to :locatable, polymorphic: true
end
