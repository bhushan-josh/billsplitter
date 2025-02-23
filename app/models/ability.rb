# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can %i[update destroy show], User, id: user.id
  end
end
