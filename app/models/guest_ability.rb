class GuestAbility
  include CanCan::Ability

  def initialize
  	can [:new, :create], User
  end
end