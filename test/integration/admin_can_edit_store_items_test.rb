class AdminCanEditItemsTest < ActionDispatch::IntegrationTest
  test "an item is updated" do
    skip
    admin = create_admin
    login(admin)

    cat_1 = Location.create(title: "Coolness")
    cat_2 = Location.create(title: "Radness")

    item = Item.create(
      title: "Hydrogen Peroxide",
      description: "For those pesky blood stains",
      price: 3,
      location_id: cat_1.id
    )

    visit item_path(item)
    click_on "Edit Item"
    assert_equal edit_admin_item_path(item), current_path

    fill_in "Title", with: "Hydrogen Peroxide Jumbo Size"
    fill_in "Price", with: 10
    select "Radness", from: "item[location_id]"

    click_on "Update Item"

    assert_equal item_path(item), current_path
    assert page.has_content? "Jumbo Size"
    assert page.has_content? 10
    assert page.has_content? cat_2.title
    refute page.has_content? 3
  end
end
