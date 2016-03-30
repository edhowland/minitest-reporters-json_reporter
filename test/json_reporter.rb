require_relative 'spec_helper'

class TestMinitest::Reporters::JsonReporter < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Minitest::Reporters::JsonReporter::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
