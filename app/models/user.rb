class User < ActiveRecord::Base
  has_many :games
  attr_accessible :name, :provider, :role, :uid
  
  GUEST_NAME = "guest"
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.role = :author
    end
  end
  
  ROLES = %w[admin author guest banned]  
  
  def self.get_guest()
    guest_user = User.where("provider = (?) and name = (?)", GUEST_NAME, GUEST_NAME).first()
    
    if guest_user.nil?
      guest_user = User.new
      guest_user.provider = :guest
      guest_user.uid = -1
      guest_user.role = :author
      guest_user.name = :guest
      guest_user.save()
    end
    
    return guest_user
  end
  
  def is_guest?()
    return self.uid == -1
  end
  
  def role?(r)
    return (role == r.to_s)
  end
end
