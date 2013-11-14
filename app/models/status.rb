class Status < ActiveRecord::Base
  attr_accessible :name, :statusable_id, :statusable_type
  belongs_to :statusable, polymorphic: true
end
