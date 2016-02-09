require "test_helper"

class UserCanEditTheirProfileTest < ActionDispatch::IntegrationTest
  test "they see updated information" do
    user = create(:user, first_name: "Penney",
                         last_name: "Gadget",
                         email: "email@zombieland.com")
    login(user)

    visit dashboard_path
    assert page.has_content? user.first_name
    assert page.has_content? user.last_name
    assert page.has_content? user.email
    click_on "Edit Profile"

    assert_equal edit_user_path(user), current_path
    fill_in "Email", with: "thepivot@issoawesome.com"
    fill_in "Last name", with: "Me"

    click_on "Submit"
    assert_equal dashboard_path, current_path

    refute page.has_content? "email@zombieland.com"
    assert page.has_content? "thepivot@issoawesome.com"
    assert page.has_content? "Me"
  end
end
