require 'test_helper'

class GuestCanViewListingTest < ActionDispatch::IntegrationTest
  test 'guest can view bunker index' do
    create_list(:bunker, 5)
    visit bunkers_path

    assert page.has_content? "Bunkers"
    assert_equal bunkers_path, current_path
    assert_equal 5, Bunker.all.count
  end

  test 'guest can view individual bunker' do
    bunker = create(:bunker)
    visit bunkers_path
    click_link_or_button bunker.title

    assert_equal bunker_path(bunker), current_path
    assert page.has_content? bunker.description
    assert page.has_content? bunker.title
    assert page.has_content? bunker.price
  end

end
