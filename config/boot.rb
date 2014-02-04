# Defines our constants
ENV['RACK_ENV'] ||= 'development'
APP_ROOT = File.expand_path('../..', __FILE__)
APP_VIEWS = File.join(APP_ROOT, '/app/views')

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

# Load Minimus Microframework
require File.expand_path('../load.rb',__FILE__)
