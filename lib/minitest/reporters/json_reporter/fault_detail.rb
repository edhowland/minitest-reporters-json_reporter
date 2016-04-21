# fault_detail.rb - class Minitest::Reporters::FaultDetail

# Minitest Base namespace for Minitest related objects
module Minitest
  # Reporters - Extensible Reporting framework for Minitest
  module Reporters
    # superclass for SkipDetail, FailDetail and ErrorDetail
    class FaultDetail < TestDetail
      def initialize(test)
        # Initialize for  FaultDetail - sets up
        # exception stuff: message, location and backtrace
        super test
      end

      # returns string of found location of this test from backtrace
      def location
        @backtrace.reverse.reduce('') do |a, e|
          break a if e =~ /in .(assert|refute|flunk|pass|fail|raise|must|wont)/
          e.sub(/:in .*$/, '')
        end
      end

      def to_h
        h = super
        h[:message] = @message
        h[:location] = location
        h
      end

      protected

      def setup_state
        @exception = @test_obj.failure
        @message = @exception.message
        @backtrace = @exception.backtrace
      end
    end
  end
end
