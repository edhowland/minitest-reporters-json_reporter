# json_reporter.rb - class MiniTest::Reporters::JsonReporter

require 'json'
require 'time'
require 'minitest'
require 'minitest/reporters'

require_relative 'json_reporter/version'
require_relative 'json_reporter/test_detail'
require_relative 'json_reporter/pass_detail'
require_relative 'json_reporter/fault_detail'

require_relative 'json_reporter/skip_detail'
require_relative 'json_reporter/error_detail'
require_relative 'json_reporter/fail_detail'



# MiniTest namespace - plugins must live here
module MiniTest
  # MiniTest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # MiniTest Reporter that produces a JSON output for interface in IDEs, editor
    class JsonReporter < BaseReporter
      def initialize
        super
        @skipped = 0
        @failed = 0
        @errored = 0
        @passed = 0
        @storage = init_status
      end

      attr_reader :storage

      def metadata_h
        {
          generated_by: self.class.name,
          version: MiniTest::Reporters::JsonReporter::VERSION,
          time: Time.now.utc.iso8601
        }
      end

      def init_status
        {
          status: green_status,
          metadata: metadata_h,
          statistics: statistics_h,
          fails: [],
          skips: []
        }
      end

      def record(test)
        super
        skipped(test) || errored(test) || failed(test) || passed(test)
      end

      def report
        super

        set_status # sets the success or failure and color in the status object
        @storage[:metadata][:options] = transform_store(options) # options only exists once test run starts
        @storage[:statistics] = statistics_h
        @storage[:passes] ||= [] if options[:verbose] # Only add this if not already added and verbose option is set

        # output JSON
        output(options[:io], @storage)
      end

      def yellow?
        @skipped > 0 && !red?
      end

      def green?
        !red? && !yellow?
      end

      def red?
        @failed + @errored > 0
      end

      private

      def set_status
        @storage[:status] = if red?
                              red_status
                            elsif yellow?
                              yellow_status
                            else
                              green_status
                            end
      end

      def color_h(code, color)
        { code: code, color: color }
      end

      def red_status
        color_h('Failed', 'red')
      end

      def yellow_status
        color_h('Passed, with skipped tests', 'yellow')
      end

      def green_status
        color_h('Success', 'green')
      end

      def statistics_h
        { total: @failed + @errored + @skipped + @passed, failed: @failed, errored: @errored, skipped: @skipped, passed: @passed }
      end

      def location(exception)
        last_before_assertion = ''

        exception.backtrace.reverse_each do |s|
          break if s =~ /in .(assert|refute|flunk|pass|fail|raise|must|wont)/
          last_before_assertion = s
        end

        last_before_assertion.sub(/:in .*$/, '')
      end

      def test_detail(type, test)
        {
          type: type,
          class: test.class.name,
          name: test.name
        }
      end

      def fault_h(type, test, e)
        h = test_detail(type, test)
        unless e.nil?
          h[:message] = e.message
          h[:location] = location(e)

          unless type == 'skipped'
            h[:backtrace] = (type == 'error' ? filter_backtrace(e.backtrace) : [])
          end
        end
        h
      end

      def status(type, test, msg, &_blk)
        result = test.send(msg)
        if result
          e = fault_h(type, test, test.failure)
          yield(e)
        end

        result
      end

      def skipped(test)
        MiniTest::Reporters::SkipDetail.new(test).query do |d|
          @skipped += 1
          @storage[:skips] << d.to_h
        end
      end

      def errored(test)
        MiniTest::Reporters::ErrorDetail.new(test).query do |d|
          d.backtrace = filter_backtrace(d.backtrace)
          @storage[:fails] << d.to_h
@errored += 1
        end
      end

      def failed(test)
        MiniTest::Reporters::FailDetail.new(test).query do |d|
          @storage[:fails] << d.to_h
          @failed += 1
        end
      end

      # Examines test if it is passed?. If it is increments @passed and optionally adds PassDetail object to .passes array if options[:verbose] == true
      def passed(test)
        MiniTest::Reporters::PassDetail.new(test).query do |d|
          @passed += 1
          if options[:verbose]
            @storage[:passes] ||= []
            @storage[:passes] << d.to_h
          end
        end
      end

      # I/O
      def output(io, body)
        io.write(JSON.dump(body))
      end

      # transform_store options: make pretty object for our JSON [metadata.options]
      # If :io is the IO class and == $stdout: "STDOUT"
      # Delete key: total_count
      def transform_store(opts)
        o = opts.clone
        o[:io] = o[:io].class.name
        o[:io] = 'STDOUT' if opts[:io] == $stdout
        o.delete(:total_count)
        o
      end
    end
  end
end
