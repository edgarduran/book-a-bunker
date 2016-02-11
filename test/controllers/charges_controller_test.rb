require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  test "should get redirected" do
    get :new
    assert_equal 302, @response.status
    assert_nil assigns(:amount)
  end

  test "should assign @amount" do
    store = Store.create(name: "Cool Store", description: "Shacks")
    bunker = create(:bunker)
    store_admin = User.create(
      first_name: "Store",
      last_name: "Admin",
      email: "storeadmin@email.com",
      password: "password",
      password_confirmation: "password"
    )
    role = Role.create(name: "store_admin")
    location = Location.create(city: "test_city")
    location.bunkers << bunker
    store.bunkers << bunker
    store_admin.roles << role
    location.stores << store
    store.users << store_admin
    cart = Cart.new("1" => 1)
    ApplicationController.any_instance.stubs(:current_user).returns(store_admin)
    ApplicationController.any_instance.stubs(:cart).returns(cart)

    get :new
    assert_equal 200, @response.status
    assert_not_nil assigns(:amount)
  end

end
