require 'test_helper'

class MailServiceTest < ActiveSupport::TestCase

  test 'it creates a cleint' do

    client = MailService.new
    assert_equal "https://api.sendgrid.com", client.client.url
  end

  test 'it sends email to customers' do
    params = "edgar@me.com"
    client = MailService.new
    client.send_email(params)
  end
end
