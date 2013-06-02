require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'auth_info'
require_relative 'sms'

NAME = 'Ann'

omars_phone = '+17208787118'
anns_phone = '+13038271604'

# sms_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
# sms_client.account.sms.messages.create(
#   :from => TWILIO_PHONE,
#   :to => omars_phone,
#   :body => create_first_text_message
# )

sms = SMS.new



get '/' do
    'Welcome to the prototype version of 56percent, where we empower women to become leaders.'
end

get '/send-message' do
  friends = {
    "+13038271604" => "Ann",
    "+17208787118" => "Omar"
  }

  sender = params[:From]
  body = params[:Body] || "No text"

  if (validate_reply(body))
    create_response(create_second_text_message(body))
  end
end