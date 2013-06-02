require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'auth_info'

omars_phone = '+17208787118'
anns_phone = '+13038271604'

txt_msg_counter = 1

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

# First question reponse handling here...
def handle_first_text_response

end

# Second question...
def create_second_text_message
end

# Response to second question here...
def handle_second_text_response

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
  text = params[:Body]

  friends = {
    "+13038271604" => "Ann",
    "+17208787118" => "Omar"
  }

  personal_name = friends[sender] || "Flower Power"
  twiml = Twilio::TwiML::Response.new do |r|
    case txt_msg_counter
    when 1
      handle_first_text_response
      txt_msg_counter += 1
    when 2
      handle_second_text_response
      txt_msg_counter = 0
    else
      puts "Should not get here..."
    end

    r.Sms "Hey you said this: #{text}, thanks for replying!"
  end
end