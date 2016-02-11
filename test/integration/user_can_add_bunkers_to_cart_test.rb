require "test_helper"

class UserCanAddBunkersToCart < ActionDispatch::IntegrationTest
  test "displays bunker information plus total cost for all bunkers in cart" do
    skip
    location = create(:location_with_bunker)
    bunker = location.bunkers.first
    store = create(:store)
    store.bunkers << bunker

    visit bunkers_path

    assert page.has_link? "Add to Cart"
    click_link "Add to Cart"
    click_link "Add to Cart"
    within ".main-nav" do
      click_link "My Cart"
    end

    assert "/cart", current_path
    assert page.has_content? bunker.title
    assert page.has_content? bunker.description
    assert page.has_content? number_to_currency(bunker.price)
    assert page.has_css?("img[src='#{bunker.image}']")
    within ".order-subtotal" do
      assert page.has_content? number_to_currency(bunker.price.to_i * 2)
    end
  end
end
