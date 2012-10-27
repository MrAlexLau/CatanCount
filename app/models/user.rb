class User < ActiveRecord::Base
  attr_accessible :name, :provider, :role, :uid
  
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.role = :author
    end
  end
  
  ROLES = %w[admin moderator author banned]  
  
  def role?(r)
    return (role == r.to_s)
  end
end
