require 'twilio-ruby'
require_relative 'auth_info'

class SMS
    INITIAL_FEELINGS = %w(Passionate Energized Connected Hopeful Aligned)
    FOLLOWUP_FEELINGS = %w(Carefree Peaceful Relieved Mellow Relaxed)

    attr_reader :client, :first_message, :second_message

    attr_writer :message_counter

    def initialize()
        @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
        create_messages
    end

    def send_first_message
        create_response(@first_message)
    end

    def receive_message(body)

    end

    def validate_reply(reply)
      return true if INITIAL_FEELINGS.include? reply
      return true if FOLLOWUP_FEELINGS.include? reply
      false
    end

private
    def create_response(body)
        twiml = Twilio::TwiML::Response.new do |r|
          r.sms body
        end

        twiml.text
    end

    def create_messages
        @first_message = create_first_text_message
        # @second_message = create_second_text_message("Mock it out!")
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
end