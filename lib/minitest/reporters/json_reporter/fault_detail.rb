# fault_detail.rb - class MiniTest::Reporters::FaultDetail

# MiniTest Base namespace for Minitest related objects
module MiniTest
  # Reporters - Extensible Reporting framework for Minitest
  module Reporters
    # FaultDetail - Subclass of TestDetail and superclass for SkipDetail, FailDetail and ErrorDetail
    class FaultDetail < TestDetail
      def initialize test
      # Initialize for  FaultDetail - sets up exception stuff: message, location and backtrace
        super test
        @exception = test.failure
        @message = @exception.message
        @backtrace = @exception.backtrace
      end

      # returns string of found location of this test from backtrace
      def location
        @backtrace.reverse.reduce('') {|a, e| break a if e =~ /assert/; e.sub(/:in .*$/, '') }
      end

        def to_h
        h = super
        h[:message] = @message
        h[:location] = location
        h
      end

    end
  end
end
