class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user = user || admin?
  end

  def destroy?
    admin?
  end

  def admin?
    user.type = 'Admin'
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

end
