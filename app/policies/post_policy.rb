# frozen_string_literal: true

# Post policy class for edit and destroy post user id should be equal to current user id
class PostPolicy < ApplicationPolicy
  def edit?
    user.id == record.user.id
  end

  def destroy?
    user.id == record.user.id
  end
end
