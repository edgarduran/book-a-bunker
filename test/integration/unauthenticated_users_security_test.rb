require "test_helper"

class UnauthenticatedUsersSecurityTest < ActionDispatch::IntegrationTest
  test "unauthenticated user can only see their own data" do
    skip
    user = create(:user_with_order)
    order = user.orders.first

    visit orders_path
    refute page.has_content? order.formatted_date
    assert page.has_content? "404"

    visit admin_dashboard_path
    assert page.has_content? "404"
    refute page.has_content? "Create New Item"
  end

  test "unauth user with duffel items redirected to login page for checkout" do
    skip
    create(:item)

    visit items_path
    click_on "Add to Duffel"
    within ".main-nav" do
      click_on "My Duffel"
    end
    click_on "Checkout"

    assert_equal login_path, current_path
  end

  test "unauth user do not have access to admin tasks" do
    skip
    visit admin_dashboard_path
    assert page.has_content? "404"
    refute page.has_content? "Create New Item"
  end
end
