# test_detail.rb - class MiniTest::Reporters::TestDetail

# MiniTest Namespace for all things Minitest
module MiniTest
  # Reporters Extensible framework for custom Minitest reporters
  module Reporters
    # Base class for detail handlers
    class TestDetail
      def initialize(test)
        @type = 'unknown'
        @class_name = test.class.name
        @name = test.name
        @predicate = :nil?
        @test_obj = test
      end

      attr_reader :test_obj, :predicate

      def query(&_blk)
        # force result to be boolean because of failure in Test is not a predicate ?
        result = (@test_obj.send(@predicate) ? true : false)
        if result
          setup_state
          yield self if block_given?
        end
        result
      end

      def to_h
        {
          type: @type,
          class: @class_name,
          name: @name
        }
      end

      protected

      def setup_state
      end
    end
  end
end
