require 'twilio-ruby'
require_relative 'auth_info'

class SMS
    INITIAL_FEELINGS = %w(Passionate Energized Connected Hopeful Aligned)
    FOLLOWUP_FEELINGS = %w(Carefree Peaceful Relieved Mellow Relaxed)

    attr_reader :client, :first_message, :second_message
    attr_accessor :answers

    def initialize()
        @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
        @answers = []
        create_messages
    end

    def send_first_message
        phone = '+17208787118'

        @client.account.sms.messages.create(
          :from => TWILIO_PHONE,
          :to => phone,
          :body => @first_message
        )
    end

    # This introduces a bug. It is possible to skip questions if the user
    # answers with a valid feeling from another question.
    def parse_response(body)
        # Handling first response
        if INITIAL_FEELINGS.include? body
            @answers.push(body)
            create_response(create_second_text_message(body))
        # Handling second response
        elsif FOLLOWUP_FEELINGS.include? body
            @answers.push(body)
            if (@answers.length >= 1)
                create_response("Feel #{@answers[0]} and #{@answers[1]} throughout the day!")
            else
                create_response("Empower youself with these feelings throughout the day. You can do it.")
            end
        else
            create_response("We're not sure how to reply, please follow up with a valid feeling.")
        end
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