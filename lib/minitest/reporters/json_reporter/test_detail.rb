# test_detail.rb - class MiniTest::Reporters::TestDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
module Reporters
    # TODO: class documentation
    class TestDetail
      def initialize(test)
        @name = 'fake'
      end

      def to_h
        {
          name: @name
        }
      end
    end
  end
end


