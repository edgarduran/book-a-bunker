require 'test_helper'

class UserCanApplyForStoreTest < ActionDispatch::IntegrationTest

  test "registered user can apply for store admin status and be approved" do
    registered_user_role = Role.create(name: "registered_user")
    platform_admin_user_role = Role.create(name: "platform_admin")
    Role.create(name: "store_admin")
    admin = create(:user)
    user = create(:user)
    admin.roles << platform_admin_user_role
    user.roles << registered_user_role

    login(user)

    assert_equal dashboard_path, current_path

    click_link "Store Application"

    assert_equal new_store_path, current_path
    assert page.has_content?("Store Application")

    fill_in "Store Name", with: "#{user.first_name}'s Store"
    fill_in "Store Description", with: "#{user.first_name}'s Store Description"
    click_button "Apply For Store"

    assert_equal dashboard_path, current_path
    assert page.has_content?("Store application submitted.")
    store = Store.all.last

    first(:link, "Logout").click
    login(admin)

    assert_equal admin_dashboard_path, current_path
    assert page.has_content?("Store Applications")
    assert page.has_content?(store.name)
    assert page.has_content?(store.description)
    assert page.has_content?(user.first_name)
    assert page.has_content?(user.last_name)

    first(:link, "Approve").click

    assert page.has_content?("Store approved.")
    assert page.has_content?(store.name)
    refute page.has_content?(store.description)
    assert page.has_content?(user.first_name)
    assert page.has_content?(user.last_name)
    assert page.has_content?(user.email)
  end

  test "registered user can apply for store admin status and be denied" do
    registered_user_role = Role.create(name: "registered_user")
    platform_admin_user_role = Role.create(name: "platform_admin")
    Role.create(name: "store_admin")
    admin = create(:user)
    user = create(:user)
    admin.roles << platform_admin_user_role
    user.roles << registered_user_role

    login(user)

    assert_equal dashboard_path, current_path

    click_link "Store Application"

    assert_equal new_store_path, current_path
    assert page.has_content?("Store Application")

    fill_in "Store Name", with: "#{user.first_name}'s Store"
    fill_in "Store Description", with: "#{user.first_name}'s Store Description"
    click_button "Apply For Store"

    assert_equal dashboard_path, current_path
    assert page.has_content?("Store application submitted.")
    store = Store.all.last

    first(:link, "Logout").click
    login(admin)

    assert_equal admin_dashboard_path, current_path
    assert page.has_content?("Store Applications")
    assert page.has_content?(store.name)
    assert page.has_content?(store.description)
    assert page.has_content?(user.first_name)
    assert page.has_content?(user.last_name)

    first(:link, "Deny").click

    assert page.has_content?("Store denied.")
    refute page.has_content?(store.name)
    refute page.has_content?(store.description)
    refute page.has_content?(user.first_name)
    refute page.has_content?(user.last_name)
    refute page.has_content?(user.email)
  end

end
