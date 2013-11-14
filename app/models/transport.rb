class Transport < ActiveRecord::Base
  attr_accessible :number, :session, :transport_type_id, :user_id
  has_many :geo_locations, as: :locatable
  has_many :statuses, as: :statusable
  belongs_to :transport_type
  belongs_to :user

end
