require "test_helper"
require "minitest/autorun"

class AuthenticatedUserTest < ActionDispatch::IntegrationTest

  test "guest is prompted to login before checking out" do
    skip
    i_need_javascript do
      location = create(:location_with_bunker)
      bunkers = location.bunkers
      store = create(:store)
      store.bunkers << bunkers
      visit bunkers_path

      click_on "Book Now!!"

      find("#myStartDatePicker").click
      find('td', :text => "16").click
      click(15)
      click_on "Select"

      click_on "Pick End Date"
      click_on "18"
      click_on "Select"

      click_on "Add to Cart"

      within ".main-nav" do
        click_on "My Cart"
      end
      click_on "Checkout"

      assert_equal login_path, current_path
    end
  end

  test "after login user is redirected to cart they previously started" do
    skip
    user = create(:user)
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    visit bunkers_path
    click_link "Add to Cart"
    within ".main-nav" do
      click_on "My Cart"
    end
    click_on "Checkout"

    assert_equal login_path, current_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    within "#login-form" do
      click_on "Login"
    end

    assert_equal cart_path, current_path
    assert page.has_content? bunker.title

    refute page.has_content? "Login"
    assert page.has_content? "Logout"
  end

  test "user can log out and is redirected to root page" do
    user = create(:user)
    role = Role.create(name: "registered_user")
    user.roles << role
    login(user)

    assert_equal dashboard_path, current_path
    assert page.has_content?("#{user.first_name}")
    assert page.has_content?("Logged in as #{user.first_name}")

    within ".main-nav" do
      click_on "Logout"
    end
    assert_equal login_path, current_path
  end
end
