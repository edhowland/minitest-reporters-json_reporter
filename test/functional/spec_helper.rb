$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'minitest/reporters/json_reporter'

require 'minitest/autorun'

MiniTest::Reporters.use!(MiniTest::Reporters::JsonReporter.new)
# MiniTest::Reporters.use!
