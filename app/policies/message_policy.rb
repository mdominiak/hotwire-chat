class MessagePolicy < ApplicationPolicy
  def update?
    user == record.author
  end

  def destroy?
    update?
  end
end
