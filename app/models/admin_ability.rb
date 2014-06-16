class AdminAbility
  include CanCan::Ability
  
  def initialize(admin)
    can :manage, :all if admin.role == "super"
    can [:read, :update], Admin, :id => admin.id
    can :index, [Admin, User]
    can :destroy, User
  end
end