# frozen_string_literal: true

class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user
    end

    def index?
      true
    end

    def show?
      index?
    end

    def new?
      return true if user.admin?
      return true if user.captain?

      false
    end

    def create?
      new?
    end

    def edit?
      return true if user.admin?
      return true if user.captain && record.user_id == user.id

      false
    end

    def update?
      edit?
    end

    def destroy?
      edit?
    end
  end
end
