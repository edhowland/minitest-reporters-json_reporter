# skip_detail.rb - class MiniTest::Reporters::SkipDetail

# MiniTest Namespace for all things Minitest
module MiniTest
  # Reporters - Extensible reporting framework for Minitest
  module Reporters
    # How to handle a skipped test.
    class SkipDetail < MiniTest::Reporters::FaultDetail
      def initialize(test)
        super
        @type = 'skipped'
      end
    end
  end
end
