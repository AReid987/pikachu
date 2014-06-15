class AdminAbility
  include CanCan::Ability
  
  def initialize(admin)
    if admin.role == "super"
      can :manage, :all 
    else
      can [:read, :update], [Admin, User]
    end  
  end
end