class CartTest < ActiveSupport::TestCase
  test "has initial contents" do
    cart = Cart.new({ "1" => 1 })

    assert_equal({ "1" => 1 }, cart.contents)
  end

  test "can add an bunker to cart" do
    cart = Cart.new({ "2" => 1 })

    cart.add_bunker(1)
    cart.add_bunker(2)

    assert_equal({ "1" => 1, "2" => 2 }, cart.contents)
  end

  test "gives total number of bunkers in cart" do
    cart = Cart.new({ "1" => 1, "2" => 2, "3" => 1 })

    assert_equal 4, cart.total
  end

  test "returns quantity for a given bunker" do
    cart = Cart.new({ "1" => 1, "2" => 2, "3" => 1 })

    assert_equal 2, cart.count_of(2)
  end

  test "returns a collection of bunkers" do
    bunker1, bunker2 = create_list(:bunker, 2)
    cart = Cart.new({ "#{bunker1.id}" => 1, "#{bunker2.id}" => 2 })

    bunkers = cart.cart_bunkers

    assert_equal [bunker1, bunker2], bunkers
  end

  test "returns the sum of all bunkers in the collection" do
    bunker1, bunker2 = create_list(:bunker, 2)
    cart = Cart.new({ "#{bunker1.id}" => 1, "#{bunker2.id}" => 2 })
    sum = bunker1.price + (bunker2.price * 2)

    assert_equal sum, cart.cart_subtotal
  end

  test "returns subtotal for the bunker" do
    bunker1, bunker2 = create_list(:bunker, 2)
    cart = Cart.new("#{bunker1.id}" => 1, "#{bunker2.id}" => 2)

    expected = bunker2.price * 2

    assert_equal expected, cart.bunker_subtotal(bunker2.id)
  end
end
