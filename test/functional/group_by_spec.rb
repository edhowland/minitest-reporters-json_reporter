# group_by_spec.rb - specs for group_by

require_relative 'spec_helper'

# group all these tests by their class
# All these tests should fail so example can use .fails[]

class TestNumericalGroup < Minitest::Test
  def test_positive_integers_are_greater_than_0
    assert_operator -1, :>, 0 
  end

end
