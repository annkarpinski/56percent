require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require_relative 'src/main/auth_info'
require_relative 'src/main/sms'

# This is SUPERBAD... damn good movie
@@sms = SMS.new

get '/' do
  'Welcome to the prototype version of 56percent, where we empower women to become leaders.'
end

get '/start' do
  @@sms.send_first_message
end

get '/send-message' do
  @@sms.parse_response(params[:Body] || "null")
end