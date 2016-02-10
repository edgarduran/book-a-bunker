require "test_helper"

class UserCanCheckoutOrder < ActionDispatch::IntegrationTest
  test "user can create an order" do
    skip
    user = create(:user)
    role = Role.create(name: "registered_user")
    user.roles << role
    create(:location_with_bunker)

    visit bunkers_path
    click_on "Add to Cart"
    click_on "Add to Cart"
    visit cart_path
    click_on "Checkout"

    assert_equal login_path, current_path

    login(user)

    assert_equal cart_path, current_path

    click_on "Checkout"

    order = user.orders.last

    assert_equal new_charge_path, current_path
    assert page.has_content? "Amount Owed"
    assert page.has_content? order.formatted_date
    assert page.has_link? "View Order"
    assert page.has_content? order.total
    assert_equal order.status, "ordered"
  end

  test "unregistered user redirects back to cart after creating an account" do
    location = create(:location_with_bunker)
    bunkers = location.bunkers
    store = create(:store)
    store.bunkers << bunkers
    Role.create(name: "registered_user")

    visit bunkers_path
    click_on "Add to Cart"
    click_on "Add to Cart"
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
