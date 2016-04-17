# pass_detail.rb - class MiniTest::Reporters::PassDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
  module Reporters
    # TODO: class documentation
    class PassDetail < MiniTest::Reporters::TestDetail
      def initialize(test) 
        super
        @type = 'passed'
        @predicate = :passed?
      end
    end
  end
end
