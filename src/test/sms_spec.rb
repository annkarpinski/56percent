require '../main/sms.rb'

describe SMS, "message" do
    before(:each) do
        @sms = SMS.new
    end

    it 'should display inital feelings in the first text' do
        feelings = SMS::INITIAL_FEELINGS & @sms.send_first_message.split(" ")
        expect(feelings.length).to eq(SMS::INITIAL_FEELINGS.length)
    end

    it 'should send the second message if the reply is valid' do
        
    end

    it 'should send an error message if the reply is not valid' do

    end

    it 'should put the user\'s response from the first text in the next message' do

    end

end