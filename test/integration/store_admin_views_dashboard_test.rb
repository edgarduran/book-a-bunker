require 'test_helper'

class StoreAdminViewsDashboardTest < ActionDispatch::IntegrationTest

  test "returning admin is redirected to dashboard upon logging in" do
    admin = create_store_admin
    login(admin)

    assert_equal "/#{admin.store.slug}/dashboard", current_path
    assert page.has_content? admin.first_name
    assert page.has_content? admin.last_name
    assert page.has_link? "Edit Store Info"
    assert page.has_content? "Orders"
  end

  test "admin can see order dashboard no orders" do
    admin = create_store_admin
    login(admin)

    assert page.has_content? "Orders"
    assert page.has_content? "No orders have been placed yet"
  end

  test "admin can see order dashboard with orders" do
    customer = create(:user)
    user_role = Role.create(name: "registered_user")
    store = create(:store)
    order = create(:order, status: "paid")
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
