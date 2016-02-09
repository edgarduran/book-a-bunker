class StoreAdminCrudFunctionalityTest < ActionDispatch::IntegrationTest

  test "admin can create a new bunker" do
    default_image = "https://upload.wikimedia.org/wikipedia/commons/0/01/Albania_bunker_2.jpg"
    admin = create_store_admin
    login(admin)

    visit store_dashboard_path(admin.store)
    click_on "Add New Bunker"

    assert_equal new_store_bunker_path(admin.store), current_path

    fill_in "Bunker Name", with: "Artist Loft Bunker"
    fill_in "Description", with: "So trendy and awesome"
    fill_in "Price", with: 100
    fill_in "Image", with: default_image
    fill_in "Bedrooms", with: 2
    fill_in "Bathromms", with: 1
    click_on "Create New Bunker"

    assert_equal store_bunker_path(Bunker.last), current_path
    within "#item-show" do
      assert page.has_content? "Artist Loft Bunker"
      assert page.has_content? "So trendy and awesome"
      assert page.has_css? "img[src=\"#{default_image}\"]"
    end
  end

  test "admin can update an existing bunker" do
    skip
  end

  test "admin can delete a bunker" do
    skip
  end

end
