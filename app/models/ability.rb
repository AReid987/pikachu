class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :update], User, :active => true, :user_id => user.id
  end
end