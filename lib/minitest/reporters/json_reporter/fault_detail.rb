# fault_detail.rb - class MiniTest::Reporters::FaultDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
  module Reporters
    # TODO: class documentation
    class FaultDetail < TestDetail
      def initialize test, exception
        super test
        @message = exception.message
        @backtrace = exception.backtrace
      end

        def to_h
        h = super
        h[:message] = @message
        h[:location] = ''
        h
      end

    end
  end
end
