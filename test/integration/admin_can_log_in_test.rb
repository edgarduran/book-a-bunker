require "test_helper"

class AdminCanLogInTest < ActionDispatch::IntegrationTest
  test "admin logs in and sees admin dashboard" do
    admin = create_store_admin
    login(admin)

    assert admin_dashboard_path, current_path
    assert page.has_content? admin.first_name
    assert page.has_content? admin.last_name
  end
end
