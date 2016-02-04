require "test_helper"

class UserCanEditBunkerNightsQuantityInCart < ActionDispatch::IntegrationTest
  test "user removes bunker from cart by subtracting until quantity is 0" do
    bunker = create(:bunker)

    visit bunkers_path
    click_link "Add to Cart"
    visit cart_path

    within ".cart-bunker-info" do
      assert page.has_content? "#{bunker.title}"
    end
    within ".order-bunker-quantity" do
      assert page.has_content? "1"
    end

    click_link_or_button "remove_circle_outline"

    refute page.has_content? "#{bunker.title}"
    refute page.has_content? "1"
  end

  test "user removes bunker from cart by clicking remove button" do
    bunker = create(:bunker)

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
    refute page.has_content? "1"
  end
end
