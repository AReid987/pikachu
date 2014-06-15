class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :update], User, :id => user.id
    cannot :index, User
  end
end