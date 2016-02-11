require 'test_helper'

class UserCanBeCreatedTest < ActionDispatch::IntegrationTest
  test "a guest can create an account" do
    Role.create(name: "registered_user")
    visit login_path
    click_on "Save yourself"

    assert_equal new_user_path, current_path

    fill_in "First name", with: "My"
    fill_in "Last name", with: "Name"
    fill_in "Email", with: "me@myself.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"

    assert_equal dashboard_path, current_path
    assert page.has_content? "My's Dashboard"
    assert page.has_content? "My Name"

    within ".main-nav" do
      click_link_or_button "Logout"
    end

    user = User.last
    assert user.registered_user?
  end

  test "user cannot create account with invalid params" do
    Role.create(name: "registered_user")
    visit login_path
    click_on "Save yourself"

    fill_in "First name", with: "My"
    fill_in "Last name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"

    assert page.has_content? "Last name can't be blank"
    assert page.has_content? "Email can't be blank"
    assert_equal users_path, current_path
  end
end
