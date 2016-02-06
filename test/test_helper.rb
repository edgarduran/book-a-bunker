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
    user = User.create(
      first_name: "Store",
      last_name: "Admin",
      email: "storeadmin@email.com",
      password: "password",
      password_confirmation: "password"
    )
    user.roles.create(name: "store_admin")
    user.stores.create(name: "Cool Store", description: "Shacks")
    user
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
