# frozen_string_literal: true

class GamePolicy < ApplicationPolicy
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
    return true if record.has_player?(user)

    false
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    return true if user.admin?
    return true if user.captain?
    return true if record.has_player?(user)

    false
  end

  def update?
    edit?
  end

  def destroy?
    return true if user.admin?
    return true if record.has_player?(user)

    false
  end

  def permitted_attributes
    [:name, :schedule_date, { team_ids: [] }]
  end
end
