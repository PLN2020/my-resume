class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
  end

  def create?
  end

  def update?
  end

  def destroy?
  end
end