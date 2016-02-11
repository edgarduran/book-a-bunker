require "test_helper"

class PlatformAdminCanFilterSitewideOrdersTest < ActionDispatch::IntegrationTest
  test "admin sees filtered results" do
    create_store_admin
    create(:store_with_bunkers)
    admin = create_platform_admin
    login(admin)
    create(:store_with_orders)
    create(:store_with_orders)

    visit admin_dashboard_path

    within ".order-status-side-bar" do
      assert page.has_link? "All Orders"
      assert page.has_content? "Ordered"
      assert page.has_content? "Paid"
      assert page.has_content? "Canceled"
      assert page.has_content? "Completed"
      click_on "Ordered"
    end

    within ".sitewide-orders" do
      refute page.has_content? "Canceled"
      refute page.has_content? "Paid"
      refute page.has_content? "Completed"
    end
  end
end
