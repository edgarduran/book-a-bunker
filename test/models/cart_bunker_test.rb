class CartBunkerTest < ActiveSupport::TestCase

  test "can instantiate cart bunker" do
    cb = CartBunker.new

    assert cb
  end

end
