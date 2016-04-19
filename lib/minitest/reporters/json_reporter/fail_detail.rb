# fail_detail.rb - class MiniTest::Reporters::FailDetail

# MiniTest Namespace for all things Minitest
module MiniTest
  # Reporters Extensible reporting framework for Minitest runs
  module Reporters
    # FailDetail Detail of failed test
    class FailDetail < FaultDetail
      def initialize test
        super
        @type = 'failure'
        @predicate = :failure
      end
    end
  end
end
