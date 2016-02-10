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

  def i_need_javascript
    initial_driver = Capybara.current_driver
    Capybara.current_driver = Capybara.javascript_driver
    yield
  ensure
    Capybara.current_driver = initial_driver
  end

  def teardown
    reset_session!
  end
end

class ActiveRecord::Base
  @@shared_connection = retrieve_connection
  def self.connection
    @@shared_connection || retrieve_connection
  end
end

def login(user)
  visit login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

# def create_admin
#   User.create(
#     first_name: "Admin",
#     last_name: "Admin",
#     email: "admin@email.com",
#     password: "password",
#     password_confirmation: "password",
#     role: 1
#   )
# end
