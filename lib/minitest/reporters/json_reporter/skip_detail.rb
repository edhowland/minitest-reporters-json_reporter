# skip_detail.rb - class MiniTest::Reporters::SkipDetail

# TODO module documentation
module MiniTest
  # TODO module documentation
  module Reporters
    # TODO: class documentation
    class SkipDetail < MiniTest::Reporters::TestDetail
      def initialize(test, exception) 
        super test
        @type = 'skipped'
      end
    end
  end
end
