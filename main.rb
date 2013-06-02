require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'auth_info'

NAME = 'Ann'
INITIAL_FEELINGS = %w(Passionate Energized Connected Hopeful Aligned)
FOLLOWUP_FEELIGNS = %w(Carefree Peaceful Relieved Mellow Relaxed)

omars_phone = '+17208787118'
anns_phone = '+13038271604'

txt_msg_counter = 1

def validate_reply(reply)
  return true if INITIAL_FEELINGS.include? reply
  return true if FOLLOWUP_FEELIGNS.include? reply
  false
end

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

# Second text question which is under 160 characters
def create_second_text_message(first_response)
%(When I feel #{first_response}, I will also feel:
Carefree
Peaceful 
Relieved
Mellow
Relaxed)
end

# Generic response helper method
def create_response(body)
    twiml = Twilio::TwiML::Response.new do |r|
      r.sms body
    end

    twiml.text
end

sms_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
sms_client.account.sms.messages.create(
  :from => TWILIO_PHONE,
  :to => omars_phone,
  :body => create_first_text_message
)

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