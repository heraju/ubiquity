class TransportType < ActiveRecord::Base
  attr_accessible :name
  has_many :transports
end
