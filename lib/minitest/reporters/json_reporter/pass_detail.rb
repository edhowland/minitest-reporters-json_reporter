# pass_detail.rb - class Minitest::Reporters::PassDetail

# Minitest Namespace for all things Minitest
module Minitest
  # Reporters Extensible framework for custom Minitest reporters
  module Reporters
    # Handler for detail of passed tests
    class PassDetail < Minitest::Reporters::TestDetail
      def initialize(test)
        super
        @type = 'passed'
        @predicate = :passed?
      end
    end
  end
end
