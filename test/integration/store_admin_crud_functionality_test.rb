class StoreAdminCrudFunctionalityTest < ActionDispatch::IntegrationTest

  test "admin can create a new bunker" do
    admin = create_store_admin
    login(admin)

    visit store_dashboard_path(admin.store)
    click_on "Add New Bunker"

    assert_equal new_store_bunker_path(admin.store.slug), current_path
    fill_in "Bunker Name", with: "Artist Loft Bunker"
    fill_in "Description", with: "So trendy and awesome"
    fill_in "Price", with: 100
    fill_in "Bedrooms", with: 2
    fill_in "Bathrooms", with: 1
    click_on "Create New Bunker"

    assert_equal store_bunkers_path(admin.store.slug), current_path

    assert page.has_content? "Artist Loft Bunker"
    assert page.has_content? "So trendy and awesome"
  end

  test "admin sees an error with incorrect info" do
  end

  test "admin can update an existing bunker" do
    admin = create_store_admin
    login(admin)

    visit store_bunkers_path(admin.store.slug)
    click_on "Edit Bunker"

    fill_in "Bunker Name", with: "Skyscraper Bunker"
    fill_in "Price", with: 500
    fill_in "Bathrooms", with: 20
    click_on "Update Bunker"

    assert page.has_content? "Bunker Updated!"
    assert_equal store_bunker_path(Store.last.slug, Bunker.last), current_path

    assert page.has_content? "Skyscraper Bunker"
    assert page.has_content? 500
    assert page.has_content? 20
  end

  test "admin can delete a bunker" do
    # login_store_admin_with_store
    admin = create_store_admin
    login(admin)
    assert page.has_content? "Artist Loft Bunker"
    assert page.has_content? "So trendy and awesome"

    click_on "Delete Bunker"

    assert page.has_content? "Bunker has been Deleted!"
    refute page.has_content? "Artist Loft Bunker"
    refute page.has_content? "So trendy and awesome"
    assert_equal store_bunkers_path(Store.last.slug), current_path
  end

end
