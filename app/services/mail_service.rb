class MailService
  attr_reader :client

  def initialize
    @client  = SendGrid::Client.new(api_key: ENV['SENDGRID_APIKEY'])
  end

  def send_email(params)
    mail = SendGrid::Mail.new do |m|
      m.to = params
      m.from = 'bunkerbooker@apocalypse.com'
      m.subject = 'Your reservation is booked'
      m.text = "Your reservation had been boooked and paid for. In the meantime, don't die."
    end

    client.send(mail)
  end

end
