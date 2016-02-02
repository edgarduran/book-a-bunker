require "test_helper"

class UserCanEditItemQuantityInCart < ActionDispatch::IntegrationTest
  test "user can update item quantity for cart items" do
    skip
    item = create(:item)

    visit items_path
    click_link "Add to Duffel"
    visit duffel_path

    within ".cart-item-info" do
      assert page.has_content? item.title
    end
    within ".order-item-quantity" do
      assert page.has_content? "1"
    end

    click_link_or_button "add_circle_outline"

    assert_equal duffel_path, current_path
    within ".order-item-quantity" do
      assert page.has_content? "2"
    end
    within ".item-subtotal" do
      assert page.has_content? number_to_currency(item.price.to_i * 2)
    end
    within ".order-subtotal" do
      assert page.has_content? number_to_currency(item.price.to_i * 2)
    end

    click_link_or_button "remove_circle_outline"

    assert_equal duffel_path, current_path
    within ".cart-item-info" do
      assert page.has_content? item.title
    end
    within ".order-item-quantity" do
      assert page.has_content? "1"
    end
    within ".order-subtotal" do
      assert page.has_content? number_to_currency(item.price)
    end
  end
end
