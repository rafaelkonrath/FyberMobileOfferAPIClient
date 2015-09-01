
# load dependencies
require 'sinatra'
require 'json'
require 'httparty'
require './lib/fyberoffer'

# Only use it for debugging
#require 'pry'

##
# Set the webserver port
set :port, 8080
#set :bind, '0.0.0.0'

##
#  The main page - Form
#
get "/" do
  erb :request
end

##
# The rendering page reply from fyber
#
post "/reply" do
  offersReply = FyberOffer.fyberofferreply params
  erb :reply, :locals => { :offers => offersReply }	
end
