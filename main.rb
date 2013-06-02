require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'src/main/auth_info'
require_relative 'src/main/sms'

NAME = 'Ann'

omars_phone = '+17208787118'
anns_phone = '+13038271604'

first_go = true
text = ""

# sms_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
# sms_client.account.sms.messages.create(
#   :from => TWILIO_PHONE,
#   :to => omars_phone,
#   :body => create_first_text_message
# )

# THIS IS SUPERBAD... damn good movie
@@sms = SMS.new

get '/' do
    'Welcome to the prototype version of 56percent, where we empower women to become leaders.'
end

get '/send-message' do
  friends = {
    "+13038271604" => "Ann",
    "+17208787118" => "Omar"
  }

  if first_go
    @@sms.send_first_message
    first_go = false
    text = "have a first go"
  else
    body = params[:Body]
    @@sms.parse_response(body)
    text = body
  end

  "#{text}"
end