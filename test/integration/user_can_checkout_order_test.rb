require "test_helper"

class UserCanCheckoutOrder < ActionDispatch::IntegrationTest
  test "user can create an order" do
    skip
    user = create(:user)
    role = Role.create(name: "registered_user")
    user.roles << role
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    # cart = Cart.new("#{bunker.id}" => 2)
    # ApplicationController.any_instance.stubs(:current_user).returns(user)
    # ApplicationController.any_instance.stubs(:cart).returns(cart)

    visit cart_path

    assert_equal cart_path, current_path

    assert page.has_content? bunker.title
    click_on "Checkout"

    assert_equal new_charge_path, current_path
  end

  test "unregistered user redirects back to cart after creating an account" do
    location = create(:location_with_bunker)
    bunkers = location.bunkers
    store = create(:store)
    store.bunkers << bunkers
    bunker = bunkers.first
    Role.create(name: "registered_user")
    cart = Cart.new("#{bunker.id}" => 2)
    ApplicationController.any_instance.stubs(:cart).returns(cart)

    visit cart_path
    click_on "Checkout"

    assert_equal login_path, current_path

    within ".create-acct" do
      click_on "Save yourself"
    end
    fill_in "First name", with: "Penney"
    fill_in "Last name", with: "Gadget"
    fill_in "Email", with: "theworldisending@uhoh.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_link_or_button "Submit"

    assert_equal cart_path, current_path
  end
end
