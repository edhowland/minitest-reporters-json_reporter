# json_reporter2.rb - ..

require 'json'
require 'minitest'
require 'minitest/reporters'

# TODO module documentation
module Minitest
  # TODO module documentation
module Reporters
  # TODO: class documentation
class JsonReporter2 < BaseReporter
  def initialize options={}
        super
        @passes = []
      end

        def record(result)
        super
        @passes << result if result.passed? && options[:verbose]
      end


      def report
        super
        @storage = {
#          fails: results.map {|e| failure_h(e) }
          skips: results.select {|e| e.skipped? }.map {|e| result_h(e, 'skipped') },
          passes: @passes.map {|e| result_h(e, 'passed') }
        }

        io.write(JSON.dump(@storage))
      end

        def result_h(result, type)
        {
          type: type,
          class: result.class.name,
          name: result.name,
          time: result.time
        }
      end
end
end
end
