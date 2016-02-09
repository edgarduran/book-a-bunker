require 'test_helper'

class GuestCanViewStoresTest < ActionDispatch::IntegrationTest
  test "guest sees all stores" do
    store_1, store_2, store_3 = create_list(:store, 3)
    visit stores_path

    assert page.has_link? store_1.name
    assert page.has_link? store_2.name
    assert page.has_link? store_3.name
  end

  test "guest can visit an individual store" do
    store = create(:store_with_bunkers)
    visit store_bunkers_path(store[:slug])
    binding.pry

    assert_equal "/#{store.slug}/bunkers", current_path
    assert page.has_content? store.name
    assert page.has_content? store.description
    assert_equal 2, store.bunkers.count
    assert page.has_content? store.bunkers.first.title
    assert page.has_content? store.bunkers.last.title
  end
end
