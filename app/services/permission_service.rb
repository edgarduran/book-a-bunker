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
    return true if controller == "home"           && action == "welcome"
    return true if controller == "users"          && action.in?(%w(show edit update))
    return true if controller == "sessions"       && action.in?(%w(new create destroy))
    return true if controller == "bunkers"        && action.in?(%w(index show))
    return true if controller == "locations"      && action.in?(%w(index show))
    return true if controller == "stores"         && action.in?(%w(index update show))
    return true if controller == "admin/users"    && action == "index"
    return true if controller == "stores/bunkers" && action.in?(%w(index show))
    return true if controller == "orders"         && action == "show"
  end

  def store_admin_permissions
    return true if controller == "home"             && action == "welcome"
    return true if controller == "users"            && action.in?(%w(show edit update))
    return true if controller == "sessions"         && action.in?(%w(new create destroy))
    return true if controller == "cart_bunkers"     && action.in?(%w(index create update))
    return true if controller == "orders"           && action.in?(%w(index create show))
    return true if controller == "bunkers"          && action.in?(%w(index show))
    return true if controller == "locations"        && action.in?(%w(index show))
    return true if controller == "stores"           && action.in?(%w(index update show))
    return true if controller == "charges"          && action == "new"
    return true if controller == "stores/bunkers"   && action.in?(%w(index show new edit update create destroy))
    return true if controller == "stores/dashboard" && action == "index"
  end

  def registered_user_permissions
    return true if controller == "home"           && action == "welcome"
    return true if controller == "users"          && action.in?(%w(show edit update))
    return true if controller == "sessions"       && action.in?(%w(new create destroy))
    return true if controller == "cart_bunkers"   && action.in?(%w(index create update))
    return true if controller == "orders"         && action.in?(%w(index create show))
    return true if controller == "bunkers"        && action.in?(%w(index show))
    return true if controller == "locations"      && action.in?(%w(index show))
    return true if controller == "stores"         && action.in?(%w(index show new create))
    return true if controller == "charges"        && action == "new"
    return true if controller == "stores/bunkers" && action.in?(%w(index show))
  end

  def guest_permissions
    return true if controller == "home"           && action == "welcome"
    return true if controller == "users"          && action.in?(%w(new create))
    return true if controller == "sessions"       && action.in?(%w(new create))
    return true if controller == "cart_bunkers"   && action.in?(%w(index create update))
    return true if controller == "bunkers"        && action.in?(%w(index show))
    return true if controller == "locations"      && action.in?(%w(index show))
    return true if controller == "stores"         && action.in?(%w(index show))
    return true if controller == "stores/bunkers" && action.in?(%w(index show))
  end
end
