require 'test_helper'

class PlatformAdminCanViewDashboardTest < ActionDispatch::IntegrationTest

  test "platform admin sees platform-admin-dashboard upon logging in" do
    skip
    platform_admin = User.create(first_name: "Mister",
                                 last_name: "Platform-Admin",
                                 email: "platformadmin@pivot.com",
                                 password: "password")
    store_admin = User.create(first_name: "Mister",
                              last_name: "Store-Admin",
                              email: "store_admin@pivot.com",
                              password: "password")
    user_store = Store.create(name: "Mister's Monkeys")
    store_admin.store = user_store
    platform_admin_role = Role.create(name: "platform_admin")
    store_admin_role = Role.create(name: "store_admin")
    platform_admin.roles << platform_admin_role
    store_admin.roles << store_admin_role

    login(platform_admin)

    assert_equal admin_dashboard_path, current_path
    assert page.has_content?("Platform Admin Dashboard")
    assert page.has_content?("Store Admins")
    assert page.has_content?(store_admin.first_name)
    assert page.has_content?(store_admin.last_name)
    assert page.has_content?(store_admin.email)
    assert page.has_content?(store_admin.store.name)
  end

end
