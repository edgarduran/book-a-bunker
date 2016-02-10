require 'test_helper'

class GuestCanViewLocationsMapTest < ActionDispatch::IntegrationTest

  test "guest can use all available bunkers button to jump to bunkers index" do
    visit root_path

    click_link "All Available Bunkers"

    assert_equal bunkers_path, current_path
    assert page.has_content?("Available Bunkers")
  end

end
