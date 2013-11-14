class Authentication < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :oauth_expires_at, :oauth_token, :provider, :uid, :user_id
end
