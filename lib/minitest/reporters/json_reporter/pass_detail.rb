# pass_detail.rb - class MiniTest::Reporters::PassDetail

# MiniTest Namespace for all things Minitest
module MiniTest
  # Reporters Extensible framework for custom Minitest reporters
  module Reporters
    # Handler for detail of passed tests
    class PassDetail < MiniTest::Reporters::TestDetail
      def initialize(test)
        super
        @type = 'passed'
        @predicate = :passed?
      end
    end
  end
end
