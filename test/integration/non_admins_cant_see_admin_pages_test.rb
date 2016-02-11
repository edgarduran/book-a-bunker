require "test_helper"

class NonAdminsCantSeeAdminPagesTest < ActionDispatch::IntegrationTest
  test "registered user can't view admin dashboard" do
    user = create(:user)
    login(user)

    visit admin_dashboard_path

    assert_equal "/", current_path
  end

  test "visitor cannot view admin dashboard" do
    visit admin_dashboard_path

    assert_equal "/", current_path
  end
end
