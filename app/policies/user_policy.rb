class UserPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def show?
    own_user_or_admin?
  end

  def update?
    own_user_or_admin?
  end

  private

  def own_user_or_admin?
    user == resource || admin?
  end

end
