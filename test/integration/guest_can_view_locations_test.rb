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
    location = create(:location)
    bunker   = create(:bunker)
    location.bunkers << bunker
    visit location_path(location)

    assert_equal location_path(location), current_path
    assert_equal 1, Bunker.count
    assert page.has_content? bunker.title
    assert page.has_content? location.city
  end
end
