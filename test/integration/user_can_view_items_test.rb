require "test_helper"

class UserCanViewAllItemsTest < ActionDispatch::IntegrationTest
  test "displays all items" do

    bunker_1, bunker_2 = create_list(:bunker, 2)

    visit "/bunkers"

    assert page.has_content?(bunker_1.title)
    assert page.has_content?(bunker_2.title)
    assert page.has_content?(bunker_1.price)
    assert page.has_css?("img[src='https://www.wpclipart.com/weapons/axe/Axe_red.svg']")
  end
end
