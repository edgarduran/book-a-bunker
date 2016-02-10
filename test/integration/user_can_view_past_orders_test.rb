require "test_helper"

class UserCanViewPastOrdersTest < ActionDispatch::IntegrationTest
  test "all order details are displayed" do
    skip
    user = create(:user)
    bunker_1 = Bunker.create(title: "Shack", price: 10, description: "Nice and airy")
    bunker_2 = Bunker.create(title: "Artist Loft", price: 500, description: "So trendy")
    login(user)

    visit bunker_path(bunker_1)
    click_on "Add to Cart"
    visit bunker_path(bunker_2)
    click_on "Add to Cart"
    visit bunker_path(bunker_2)
    click_on "Add to Cart"

    visit cart_path
    click_on "Checkout"

    order = user.orders.all.first
    order_date = order.formatted_date

    visit orders_path

    assert page.has_content? order_date
    assert page.has_link? "View Order"
    click_on "View Order"
    assert_equal order_path(order), current_path

    assert page.has_content? bunker_1.title
    assert page.has_content? bunker_2.title

    order.order_bunkers.each do |order_bunker|
      assert page.has_content? order_bunker.quantity
    end

    order.bunker_subtotals.each do |bunker_subtotal|
      assert page.has_content? number_to_currency(bunker_subtotal)
    end

    assert page.has_link? bunker_1.title
    assert page.has_link? bunker_2.title

    assert page.has_content? "ordered"
    assert page.has_content? number_to_currency(order.total)
    assert page.has_content? order.formatted_date
  end
end
