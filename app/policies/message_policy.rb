class MessagePolicy < ApplicationPolicy
  def show?
    true
  end
  
  def update?
    user == record.author
  end

  def destroy?
    update?
  end
end
