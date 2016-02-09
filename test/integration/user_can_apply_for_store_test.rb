require 'test_helper'

class UserCanApplyForStoreTest < ActionDispatch::IntegrationTest

  test "registered user can apply for store admin status" do
    registered_user_role = Role.create(name: "registered_user")
    user = create(:user)
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
  end

end
