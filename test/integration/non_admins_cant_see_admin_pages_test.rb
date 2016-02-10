require "test_helper"

class NonAdminsCantSeeAdminPagesTest < ActionDispatch::IntegrationTest
  test "registered user can't view admin dashboard" do
    skip
    user = create(:user)
    login(user)

    visit admin_dashboard_path

    assert page.has_content? "404"
    assert page.has_content? "The page you were looking for doesn't exist."
  end

  test "visitor cannot view admin dashboard" do
    skip
    visit admin_dashboard_path

    assert page.has_content? "404"
    assert page.has_content? "The page you were looking for doesn't exist."
  end
end
