require "test_helper"

class UserCanViewBunkersTest < ActionDispatch::IntegrationTest
  test "displays all bunkers" do

    bunker_1, bunker_2 = create_list(:bunker, 2)

    visit "/bunkers"

    assert page.has_content?(bunker_1.title)
    assert page.has_content?(bunker_2.title)
    assert page.has_content?(bunker_1.price)
    assert page.has_css?("img[src='https://upload.wikimedia.org/wikipedia/commons/0/01/Albania_bunker_2.jpg']")
  end
end
