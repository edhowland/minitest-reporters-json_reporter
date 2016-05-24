# spec_helper.rb - helper harness for minispec for minitest-reporters-json_reporter
# Possibly require SimpleCov libs if user has ~/.load_simplecov
# require_relative 'load_simplecov' if File.exist?(File.expand_path('~/.load_simplecov'))
require 'coveralls'
Coveralls.wear!

require_relative 'load_path'

require 'minitest/autorun'
