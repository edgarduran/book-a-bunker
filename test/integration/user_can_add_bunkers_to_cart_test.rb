require "test_helper"

class UserCanAddBunkersToCart < ActionDispatch::IntegrationTest

  test "displays bunker information plus total cost for all bunkers in cart" do
    skip
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    store = create(:store)
    store.bunkers << bunker
    user = create(:user)
    user.roles.create(name: "store_admin")
    # cart = Cart.new("#{bunker.id}" => 2)
    # ApplicationController.any_instance.stubs(:current_user).returns(user)
    # ApplicationController.any_instance.stubs(:set_cart).returns(cart)
    # ApplicationController.any_instance.stubs(:cart).returns(cart)


    visit cart_path

    assert_equal cart_path, current_path
    assert page.has_content? bunker.title
    assert page.has_content? bunker.description
    assert page.has_content? number_to_currency(bunker.price)
    assert page.has_css?("img[src='#{bunker.image}']")
    assert page.has_content? number_to_currency(bunker.price.to_i)
  end
end
