require "test_helper"

class UserCanEditBunkerNightsQuantityInCart < ActionDispatch::IntegrationTest
  test "user can update bunker quantity for cart bunkers" do
    bunker = create(:bunker)
    visit bunkers_path
    click_link "Add to Cart"
    visit cart_path

    within ".cart-bunker-info" do
      assert page.has_content? bunker.title
    end
    within ".order-bunker-quantity" do
      assert page.has_content? "1"
    end

    click_link_or_button "add_circle_outline"

    assert_equal cart_path, current_path
    within ".order-bunker-quantity" do
      assert page.has_content? "2"
    end
    within ".bunker-subtotal" do
      assert page.has_content? number_to_currency(bunker.price.to_i * 2)
    end
    within ".order-subtotal" do
      assert page.has_content? number_to_currency(bunker.price.to_i * 2)
    end

    click_link_or_button "remove_circle_outline"

    assert_equal cart_path, current_path
    within ".cart-bunker-info" do
      assert page.has_content? bunker.title
    end
    within ".order-bunker-quantity" do
      assert page.has_content? "1"
    end
    within ".order-subtotal" do
      assert page.has_content? number_to_currency(bunker.price)
    end
  end
end
