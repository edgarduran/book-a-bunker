require 'test_helper'

class PlatformAdminCanDeactivateAnApprovedStoreTest < ActionDispatch::IntegrationTest

  test "platform admin can deactivate an approved and existing store" do
    admin = create(:user)
    store_admin = create(:user)
    store_admin_2 = create(:user)
    Role.create(name: "registered_user")
    platform_admin_user_role = Role.create(name: "platform_admin")
    admin.roles << platform_admin_user_role
    store = Store.create(name: "test store",
                         description: "store description",
                         approved: true)
     store_2 = Store.create(name: "test store 2",
                          description: "store description2",
                          approved: true)
    store_admin_user_role = Role.create(name: "store_admin")
    store_admin.roles << store_admin_user_role
    store_admin_2.roles << store_admin_user_role
    store.users << store_admin
    store_2.users << store_admin_2
    approved_store = Store.create(name: "store_name",
                                  description: "store_description",
                                  approved: true)
    login(admin)

    assert_equal admin_dashboard_path, current_path
    assert page.has_content? store_admin.first_name
    assert page.has_content? store_admin.last_name
    assert page.has_content? store_admin.email
    assert page.has_content? store_admin.store.name
    assert page.has_content? store_admin_2.first_name
    assert page.has_content? store_admin_2.last_name
    assert page.has_content? store_admin_2.email
    assert page.has_content? store_admin_2.store.name

    first(:link, "Deactivate").click

    assert page.has_content?("Store deactivated.")
  end

end
