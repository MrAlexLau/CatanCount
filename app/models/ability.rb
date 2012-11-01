class Ability
  include CanCan::Ability

  # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

  def initialize(user)
    if not user.nil?
      if user.role?(:admin)        
        can :manage, :all   
      elsif user.role?(:author)
        can :manage, Game, :user_id => user.id
        can :manage, Roll
        cannot :read, User       
      elsif user.role?(:guest)
        can :read, Game
        can :read, Roll
        cannot :read, User        
      elsif user.role?(:banned)
        cannot :read, :all       
      end
    end    
  end
end
