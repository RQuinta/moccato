class UserObserver < ActiveRecord::Observer

  def after_save(user)
    1
  end

end