require "test_helper"

class UnauthenticatedUsersSecurityTest < ActionDispatch::IntegrationTest
  test "unauthenticated user can only see their own data" do
    user = create(:user_with_order)
    order = user.orders.first

    visit orders_path
    refute page.has_content? order.formatted_date

    visit admin_dashboard_path
    assert_equal "/", current_path
  end

end
