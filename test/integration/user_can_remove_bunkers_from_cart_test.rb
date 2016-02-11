require "test_helper"

class UserCanEditBunkerNightsQuantityInCart < ActionDispatch::IntegrationTest
  test "user removes bunker from cart by subtracting until quantity is 0" do
    skip
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    store = create(:store)
    store.bunkers << bunker
    user = create(:user)
    user.roles.create(name: "registered_user")
    cart = Cart.new("#{bunker.id}" => 1)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    ApplicationController.any_instance.stubs(:cart).returns(cart)

    visit cart_path
    # within ".cart-bunker-info" do
      assert page.has_content? bunker.title
    # end
    within ".order-bunker-quantity" do
      assert page.has_content? "1"
    end

    click_link_or_button "#remove_bunker_button"
    refute page.has_content? "#{bunker.title}"
  end

  test "user removes bunker from cart by clicking remove button" do
    skip
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    store = create(:store)
    store.bunkers << bunker

    visit bunkers_path
    click_link "Add to Cart"
    visit cart_path

    within ".cart-bunker-info" do
      assert page.has_content? "#{bunker.title}"
    end
    within ".order-bunker-quantity" do
      assert page.has_content? "1"
    end

    click_link_or_button "remove"

    refute page.has_content? "#{bunker.title}"
  end
end
