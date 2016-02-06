require 'test_helper'

class StoreAdminViewsDashboardTest < ActionDispatch::IntegrationTest
  test "returning admin is redirected to dashboard upon logging in" do
    admin = create_store_admin
    visit login_path

    fill_in "Email", with: admin.email
    fill_in "Password", with: "password"

    within "#login-form" do
      click_on "Login"
    end

    assert_equal store_admin_dashboard_path, current_path
    assert page.has_content? admin.first_name
    assert page.has_content? admin.last_name
  end
end


# As a logged in store admin
# When I visit my dashboard
# I see my profile information
# And I see a table with all my stores order
# And the status for each order (paid, canceled, etc.)
# And I can change the status of any order
# And each order links to a page with details for that order
# And I see a link to add a new bunker to my store
