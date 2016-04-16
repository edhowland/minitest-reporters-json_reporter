# test_detail.rb - class MiniTest::Reporters::TestDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
module Reporters
    # TODO: class documentation
    class TestDetail
      def initialize(test)
        @type = 'unknown'
        @class_name = 'TestDouble'
        @name = 'fake'
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


