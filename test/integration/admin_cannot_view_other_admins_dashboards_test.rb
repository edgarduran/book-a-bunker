require "test_helper"

class AdminCannotViewOtherAdminsDashboards < ActionDispatch::IntegrationTest
  test "store admin does not see platform admin dashboard" do
    user = create_store_admin
    login(user)

    visit admin_dashboard_path
    assert_equal "/", current_path
  end

  test "platform admin does not see store admin dashboard" do
    create_store_admin
    store = create(:store_with_bunkers)
    platform_admin = create_platform_admin
    login(platform_admin)

    visit store_dashboard_path(store.slug)
    assert_equal "/", current_path
  end
end
