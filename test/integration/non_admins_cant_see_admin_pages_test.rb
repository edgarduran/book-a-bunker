require "test_helper"

class NonAdminsCantSeeAdminPagesTest < ActionDispatch::IntegrationTest
  test "registered user cannot view platform admin dashboard" do
    user = create(:user)
    login(user)

    visit admin_dashboard_path
    assert_equal "/", current_path
  end

  test "visitor cannot view platform admin dashboard" do
    visit admin_dashboard_path

    assert_equal "/", current_path
  end

  test "registered user cannot view store admin dashboard" do
    user = create(:user)
    login(user)
    store = create(:store_with_bunkers)

    visit "#{store.slug}/dashboard"
    assert_equal "/", current_path
  end

  test "visitor cannot view store admin dashboard" do
    store = create(:store_with_bunkers)

    visit "#{store.slug}/dashboard"
    assert_equal "/", current_path
  end
end
