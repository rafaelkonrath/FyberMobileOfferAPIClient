require './app'
require 'test/unit'
require 'rack/test'


class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index_returns
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Fyber Mobile Offer API')
  end

  def test_offers_returns
  	post '/reply', {:uid => "player1", :pub0 => "campaign2", :page => "2"}
  	assert last_response.ok?
    assert last_response.body.include?('Well done')
  end

  def test_no_offer_returns
  	post '/reply', {:uid => "0", :pub0 => "0", :page => "0"}
  	assert last_response.ok?
    assert last_response.body.include?('No Offers Available')
  end  
end
