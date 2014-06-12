class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :update], User, :active => true, :user_id => user.id
  end

  def initialize(admin)
    admin ||= Admin.new
    if admin.role == :super
      can :manage, :all
    else
      can [:read, :update], [Admin, User]
    end
  end
end