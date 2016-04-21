
# error_detail.rb - class Minitest::Reporters::ErrorDetail

# Minitest Namespace for all things Minitest
module Minitest
  # Reporters Namespace for Minitest::Reporters reporters
  module Reporters
    # How to handle an error detail
    class ErrorDetail < FaultDetail
      def initialize(test)
        super
        @type = 'error'
        @predicate = :error?
      end

      attr_accessor :backtrace

      def to_h
        h = super
        h[:backtrace] = @backtrace
        h
      end
    end
  end
end
