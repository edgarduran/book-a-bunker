require 'test_helper'

class GuestCanViewLocationsTest < ActionDispatch::IntegrationTest
  test 'guest can view location index' do
    locations = create_list(:location, 5)
    visit locations_path

    assert_equal 5, locations.count
    assert page.has_content? "Locations"
    assert page.has_content? locations.first.city
    assert page.has_content? locations.last.city
  end

  test 'guest can view bunkers by location' do
    location = create(:location_with_bunker)
    bunkers = location.bunkers
    store = create(:store)
    store.bunkers << bunkers
    visit location_path(location.slug)

    assert_equal location_path(location.slug), current_path
    assert_equal 1, Bunker.count
    assert page.has_content? location.bunkers.first.title
    assert page.has_content? location.city
  end

  test 'guest can view bunkers index map on homepage and follow a link to location show page' do
    location = create(:location, city: "Augusta")

    visit root_path

    click_link('augusta_link')
    assert_equal location_path(location.slug), current_path
  end
end
