class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user.platform_admin?
      platform_admin_permissions
    elsif user.store_admin?
      store_admin_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_permissions
    end
  end

  private

  def platform_admin_permissions
    return true
  end

  def store_admin_permissions
    return true
  end

  def registered_user_permissions
    return true
  end

  def guest_permissions
    return true
  end
end
