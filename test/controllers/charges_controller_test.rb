require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  test "should get redirected" do
    get :new
    assert_equal 302, @response.status
    assert_nil assigns(:amount)
  end

end
