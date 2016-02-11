require "test_helper"

class UserSeesErrorWithIncorrectFieldTest < ActionDispatch::IntegrationTest
  test "user does not provide email" do
    visit new_user_path

    fill_in "First name", with: "Penney"
    fill_in "Last name", with: "Gadget"
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"

    assert page.has_content? "Email can't be blank"
    assert_equal users_path, current_path
  end

  test "user email is not valid" do
    visit new_user_path

    fill_in "First name", with: "Penney"
    fill_in "Last name", with: "Gadget"
    fill_in "Email", with: "abcdefg@123..com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Submit"

    assert page.has_content? "Email is invalid"
    assert_equal users_path, current_path
  end

  test "password must be at least 6 characters long" do
    visit new_user_path

    fill_in "First name", with: "Penney"
    fill_in "Last name", with: "Gadget"
    fill_in "Email", with: "penney@email.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Submit"

    assert page.has_content? "Password is too short (minimum is 6 characters)"
    assert_equal users_path, current_path
  end

  test "password must be correct" do
    user = create(:user)

    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Login"

    assert page.has_content? "Invalid Login"
    assert_equal login_path, current_path
  end
end
