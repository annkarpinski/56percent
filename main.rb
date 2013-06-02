require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'auth_info'

omars_phone = '+17208787118'
anns_phone = '+13038271604'

# Had to alter first text due to message going over 160 character limit
def create_first_text_message
%(Today, I want to feel:
Passionate
Energized
Connected
Hopeful
Aligned
)
end

@sms_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

@sms_client.account.sms.messages.create(
  :from => TWILIO_PHONE,
  :to => omars_phone,
  :body => create_first_text_message
)

get '/' do
    'Currently running version ' + Twilio::VERSION + \
        ' of the twilio-ruby library.'
end

get '/send-message' do
  sender = params[:From]

  friends = {
    "+13038271604" => "Ann",
    "+17208787118" => "Omar"
  }

  personal_name = friends[sender] || "Flower Power"
  twiml = Twilio::TwiML::Response.new do |r|
    r.Sms "Hey, #{personal_name}, thanks for replying!"
  end
  twiml.text
end


# First question reponse handling here...


# Second question...


# Response to second question here...