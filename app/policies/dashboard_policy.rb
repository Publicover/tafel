# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user
    end

    def index?
      true
    end
  end
end
