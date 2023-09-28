class PostPolicy < ApplicationPolicy
  def edit?
    user.id == record.user.id
  end

  def destroy?
    user.id == record.user.id
  end
end
