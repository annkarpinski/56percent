require 'twilio-ruby'
require_relative 'auth_info'

home_phone = '7208787118'

@sms_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

@sms_client.account.sms.messages.create(
  :from => TWILIO_PHONE,
  :to => home_phone,
  :body => 'Texting you from a Ruby script!'
)