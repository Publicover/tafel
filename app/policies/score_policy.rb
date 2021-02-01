# frozen_string_literal: true

class ScorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true if user.admin?

    false
  end

  def show?
    return true if user.admin?
    return true if record.player?(user)

    false
  end

  def new?
    return true if user.admin?

    false
  end

  def create?
    new?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    new?
  end

  def permitted_attributes
    [:points, :game_id, :team_id]
  end
end
