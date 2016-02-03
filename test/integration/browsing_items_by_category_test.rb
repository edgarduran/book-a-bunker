require "test_helper"

class BrowseItemsByLocationTest < ActionDispatch::IntegrationTest
  test "items can be viewed by location" do
    skip
    location_1, location_2 = create_list(:location_with_items, 2)

    visit "/locations/#{location_1.title}"

    assert page.has_content? location_1.items.first.title
    assert page.has_content? location_1.items.last.title

    visit "/locations/#{location_2.title}"

    assert page.has_content? location_2.items.first.title
    assert page.has_content? location_2.items.last.title
  end
end
