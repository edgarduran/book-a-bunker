require 'test_helper'

class StoreAdminViewsDashboardTest < ActionDispatch::IntegrationTest
  attr_reader :admin

  def login_store_admin
    @admin = create_store_admin
    visit login_path

    fill_in "Email", with: admin.email
    fill_in "Password", with: "password"

    within "#login-form" do
      click_on "Login"
    end
  end

  test "returning admin is redirected to dashboard upon logging in" do
    login_store_admin

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store.id}", current_path
    assert page.has_content? admin.first_name
    assert page.has_content? admin.last_name
    assert page.has_link? "Edit Store Info"
    assert page.has_link? "View Store's Orders"
  end

  test "admin can see order dashboard no orders" do
    login_store_admin

    assert page.has_content? "Orders"
    assert page.has_content? "No orders to show at this time"
  end

  test "admin can see order dashboard with orders" do
    customer = create(:user)
    user_role = Role.create(name: "registered_user")
    store = create(:store)
    order = create(:order)
    user = create(:user)
    admin_role = Role.create(name: "store_admin")
    customer.roles << user_role
    customer.orders << order
    store.orders << order
    user.roles << admin_role
    store.users << user

    login(user)


    assert page.has_content? "Orders"
    assert page.has_content? customer.first_name
    assert page.has_content? customer.last_name
    assert page.has_content? order.formatted_date
    assert page.has_content? order.status
    assert_equal 1, store.orders.count
  end


end


# And I see a table with all my stores order
# And the status for each order (paid, canceled, etc.)
# And I can change the status of any order
# And each order links to a page with details for that order
# And I see a link to add a new bunker to my store
