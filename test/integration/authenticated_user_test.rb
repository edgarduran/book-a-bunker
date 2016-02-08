require "test_helper"

class AuthenticatedUserTest < ActionDispatch::IntegrationTest
  test "guest is prompted to login before checking out" do
    create(:location_with_bunker)

    Capybara.register_driver :selenium do |app|
      driver = Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    binding.pry
    driver.navigate.to bunkers_path
    element = driver.find_element(:name, 'q')
    element.send_keys "Hello WebDriver!"
    element.submit

    click_link "Add to Cart"
    within ".main-nav" do
      click_on "My Cart"
    end
    click_on "Checkout"

    assert_equal login_path, current_path
  end

  test "after login user is redirected to cart they previously started" do
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
