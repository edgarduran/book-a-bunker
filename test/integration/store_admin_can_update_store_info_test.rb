require "test_helper"

class StoreAdminCanUpdateStoreInfoTest < ActionDispatch::IntegrationTest

  test "store_admin_can_edit_stores_info" do
    admin = create_store_admin
    Location.create(city: "Denver")
    login(admin)

    visit store_dashboard_path(admin.store)

    click_link "Edit Store Info"

    fill_in "Store Name", with: "New Store"
    fill_in "Store Description", with: "This store is now way better"


    click_on "Apply Changes"

    assert page.has_content? "New Store"
    assert_equal "/new-store/dashboard", current_path
  end

end
