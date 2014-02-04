ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require File.expand_path("../../config/boot.rb", __FILE__)

include Rack::Test::Methods

def app
  Minimus::Router.app
end
