require_relative '../helloworld.rb'
require 'minitest/autorun'
require 'minitest/ci'
require 'rack/test'

class HelloWorldTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_hello_world
    get '/'

    assert last_response.ok?
    assert_includes last_response.body, "Hello"
  end

  def test_hello_universe
    get '/morethanworld'

    assert last_response.ok?
    assert_includes last_response.body, "Multiverse"
  end
end