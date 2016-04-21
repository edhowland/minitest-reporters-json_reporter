$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'minitest/reporters/json_reporter'

require 'minitest/autorun'

Minitest::Reporters.use!(Minitest::Reporters::JsonReporter.new)
# Minitest::Reporters.use!
