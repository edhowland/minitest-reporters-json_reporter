# load_simplecov.rb - requires for simplecov gem
require 'simplecov'
require 'simplecov-json'
SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start do
  add_filter '/test/'
end if ENV['COV'] == '1'

$simplecov_loaded = true
