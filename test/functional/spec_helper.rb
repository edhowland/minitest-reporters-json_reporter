$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'minitest/reporters/json_reporter'

require 'minitest/autorun'

bt_filter = Minitest::ExtensibleBacktraceFilter.default_filter
bt_filter.add_filter /minitest/
MiniTest::Reporters.use!(MiniTest::Reporters::JsonReporter.new)
#MiniTest::Reporters.use! 
