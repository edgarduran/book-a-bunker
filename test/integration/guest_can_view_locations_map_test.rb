require 'test_helper'

class GuestCanViewLocationsMapTest < ActionDispatch::IntegrationTest

  test "guest can use find shelter button to jump to home page map" do
    visit root_path

    click_link "Find Shelter"

    assert_equal root_path, current_path
    assert page.has_content?("Find Shelter")
    assert page.has_css?('.locations-map')
  end

end
