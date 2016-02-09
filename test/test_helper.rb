ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "capybara/rails"
require "simplecov"
include ActionView::Helpers::NumberHelper

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  SimpleCov.start("rails")
  include FactoryGirl::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    reset_session!
  end

  def login(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
  end

  def create_store_admin
    store = Store.create(name: "Cool Store", description: "Shacks")
    store_admin = User.create(
      first_name: "Store",
      last_name: "Admin",
      email: "storeadmin@email.com",
      password: "password",
      password_confirmation: "password"
    )
    role = Role.create(name: "store_admin")
    store_admin.roles << role
    store.users << store_admin
    store_admin
  end

  def login_store_admin
    admin = create_store_admin
    visit login_path

    fill_in "Email", with: admin.email
    fill_in "Password", with: "password"

    within "#login-form" do
      click_on "Login"
    end
  end

  def login_store_admin_with_store
    admin = create_store_admin
    login(admin)
    visit store_dashboard_path(admin.store)
    click_on "Add New Bunker"
    fill_in "Bunker Name", with: "Artist Loft Bunker"
    fill_in "Description", with: "So trendy and awesome"
    fill_in "Price", with: 100
    fill_in "Bedrooms", with: 2
    fill_in "Bathrooms", with: 1
    click_on "Create New Bunker"
  end

  # def create_platform_admin
  #   user = User.create(
  #     first_name: "Platform",
  #     last_name: "Admin",
  #     email: "platformadmin@email.com",
  #     password: "password",
  #     password_confirmation: "password"
  #   )
  #   user.roles.create(name: "platform_admin")
  # end
end
