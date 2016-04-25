$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'minitest/reporters/json_reporter2'

require 'minitest/autorun'

Minitest::Reporters.use!(Minitest::Reporters::JsonReporter2.new)
# Minitest::Reporters.use!
