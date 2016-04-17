# test_detail.rb - class MiniTest::Reporters::TestDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
module Reporters
    # TODO: class documentation
    class TestDetail
      def initialize(test)
        @type = 'unknown'
        @class_name = test.class.name
        @name = test.name
        @predicate = :nil?
        @test_obj = test
      end

      attr_reader :test_obj, :predicate


      def query &blk
        result = @test_obj.send @predicate
        yield self if result && block_given?
        result
      end

      def to_h
        {
          type: @type,
        class: @class_name,
          name: @name
        }
      end
    end
  end
end


