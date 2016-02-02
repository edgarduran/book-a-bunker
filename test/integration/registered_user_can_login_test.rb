require "test_helper"

class RegisteredUserCanLoginTest < ActionDispatch::IntegrationTest
  test "registered user can log back in and see their dashboard" do
    skip
    user = create(:user)

    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal dashboard_path, current_path
    assert page.has_content?("#{user.first_name}")
    assert page.has_content?("Logged in as #{user.first_name}")
  end
end
