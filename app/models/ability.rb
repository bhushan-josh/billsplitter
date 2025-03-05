class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.admin?

    can :manage, :all
  end
end
