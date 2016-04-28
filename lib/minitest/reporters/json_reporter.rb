# json_reporter.rb - class Minitest::Reporters::JsonReporter

require 'json'
require 'time'

require 'minitest'
require 'minitest/reporters'

require_relative 'json_reporter/version'
# Minitest namespace - plugins must live here
module Minitest
  # Minitest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # Minitest Reporter that produces a JSON output for interface in IDEs, CD/CI tools and codeeditors
    class JsonReporter < BaseReporter
      def initialize options={}
        super
      end

      attr_accessor :storage

      def report
        super

#binding.pry
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
        tests.reject {|e| e.skipped? or e.passed? }.map {|e| failure_h(e) }
      end

      def failure_h(result)
        if result.error?
          error_h(result)
        else
          failed_h(result)
        end
      end

      def error_h(result)
        h = result_h(result, 'error')
        h[:message] = result.failure.message
        h[:location] = location(result.failure)
        h[:backtrace] = filter_backtrace(result.failure.backtrace)
        h
      end

      def failed_h(result)
        h = result_h(result, 'failed')
        h[:message] = result.failure.message
        h[:location] = location(result.failure)
        h
      end

        def skips_h
        tests.select {|e| e.skipped? }.map {|e| skip_h(e) }
      end

      def skip_h(result)
        h = result_h(result, 'skipped')
        h[:message] = result.failure.message
        h[:location] = location(result.failure)
        h
      end

      def passes_h
        tests.select {|e| e.passed? }.map{|e| result_h(e, 'passed') } 
      end

        def result_h(result, type)
        {
          type: type,
          class: result.class.name,
          name: result.name,
          assertions: result.assertions,
          time: result.time
        }
      end

      def location(exception)
        last_before_assertion = ''

        exception.backtrace.reverse_each do |s|
          break if s =~ /in .(assert|refute|flunk|pass|fail|raise|must|wont)/
          last_before_assertion = s
        end

        last_before_assertion.sub(/:in .*$/, '')
      end
    end
  end
end
