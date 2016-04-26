# json_reporter2.rb - ..

require 'json'
require 'time'

require 'minitest'
require 'minitest/reporters'

require_relative 'json_reporter/version'

# TODO module documentation
module Minitest
  # TODO module documentation
module Reporters
  # TODO: class documentation
class JsonReporter2 < BaseReporter
  def initialize options={}
        super
      end



      def report
        super
        @storage = {
          status: status_h,
          metadata: metadata_h,
          statistics: statistics_h,
          timings: timings_h,
          fails: failures_h,
          skips: skips_h
        }
        @storage[:passes] = passes_h if options[:verbose]

        io.write(JSON.dump(@storage))
      end

        def status_h
        {
          code: ['Failed', 'Passed with skipped tests', 'Success'][color_i],
          color: ['red', 'yellow', 'green'][color_i]
        }
      end

      # return index corresponding to red, yellow or green
      # if errors or failures, skips or passes (default)
      def color_i
        if (failures + errors) > 0
          0
        elsif skips > 0
          1
        else
          2
        end
      end


      def metadata_h
        {
          generated_by: self.class.name,
          version: Minitest::Reporters::JsonReporter::VERSION,
          time: Time.now.utc.iso8601,
          options: transform(options)
        }
      end

      def transform(opts)
        o = opts.clone
        o[:io] = o[:io].class.name
        o[:io] = 'STDOUT' if opts[:io] == $stdout
        o
      end

      def statistics_h
        {
          total: count,
          assertions: assertions,
          failures: failures,
          errors: errors,
          skips: skips,
          passes: (count - (failures + errors + skips))
        }
      end

      def timings_h
        {
          total_seconds: total_time,
          runs_per_second: count / total_time,
          assertions_per_second: assertions / total_time
        }
      end

        def failures_h
        tests.reject {|e| e.skipped? or e.passed? }.map {|e| result_h(e, (e.error? ? 'error' : 'failure')) }
      end


        def skips_h
        tests.select {|e| e.skipped? }.map {|e| result_h(e, 'skipped') }
      end

      def passes_h
        tests.select {|e| e.passed? }.map{|e| result_h(e, 'passed') } 
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
