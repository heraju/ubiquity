class User < ActiveRecord::Base
  has_many :authentications
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_and_belongs_to_many :roles
  has_many :geo_locations, as: :locatable
  has_many :statuses, as: :statusable
  has_many :transports

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :gender, :phone_number, :sos_number, :password_hint, :sos_email
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    #puts access_token.inspect
    if user = User.find_by_email(data.email)
      authentication = Authentication.find_or_create_by_provider_and_uid(access_token.provider, access_token.uid)
      user.authentications << authentication if authentication.update_attributes(:oauth_token => access_token.credentials.token, :oauth_expires_at => Time.at(access_token.credentials.expires_at))
    user
    else # Create a user with a stub password. 
      user = User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :first_name => data.first_name, :last_name => data.last_name, :gender => data.gender)
      user.authentications << Authentication.create!(:provider => access_token.provider, :oauth_token => access_token.credentials.token, :uid => access_token.uid, :oauth_expires_at => Time.at(access_token.credentials.expires_at))
      user
    end
  end
end
