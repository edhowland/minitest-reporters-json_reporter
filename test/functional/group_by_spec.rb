# group_by_spec.rb - specs for group_by

require_relative 'spec_helper'

# group all these tests by their class
# All these tests should fail so example can use .fails[]

class TestNumericalGroup < Minitest::Test
  def test_positive_integers_are_greater_than_0
    assert_operator -1, :>, 0 
  end

  def test_4_times_6_equals_24
    assert_equals(4 * 6, 24)
  end
end

# TODO: class documentation
class TestStringGroup < Minitest::Test
  def setup
    @value = 'Goodby World'
  end

  def test_string_is_hello_world
    assert_equals @value, 'Hello World'
  end

  def test_value_length_equals_2
    assert_equals @value.length, 2
  end
end
