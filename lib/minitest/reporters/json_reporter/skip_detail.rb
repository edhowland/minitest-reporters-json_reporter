# skip_detail.rb - class Minitest::Reporters::SkipDetail

# Minitest Namespace for all things Minitest
module Minitest
  # Reporters - Extensible reporting framework for Minitest
  module Reporters
    # How to handle a skipped test.
    class SkipDetail < Minitest::Reporters::FaultDetail
      def initialize(test)
        super
        @type = 'skipped'
        @predicate = :skipped?
      end
    end
  end
end
