# json_reporter.rb - class MiniTest::Reporters::JsonReporter

require 'json'
require 'time'
require 'minitest'
require 'minitest/reporters'

require_relative 'json_reporter/version'

# MiniTest namespace - plugins must live here
module MiniTest
  # MiniTest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # MiniTest Reporter that produces a JSON output for interface in IDEs, editor
    class JsonReporter < BaseReporter
      def initialize(opts = {})
        super(opts)
        @skipped = 0
        @failed = 0
        @errored = 0
        @passed = 0
        @storage = init_status
      end

      def metadata_h
        {
          generated_by: self.class.name,
          version: MiniTest::Reporters::JsonReporter::VERSION,
          time: Time.now.utc.iso8601
        }
      end

      def init_status
        {
          status: red_status,
          metadata: metadata_h,
          statistics: {},
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
        set_status # sets the sucess or failure and color in the status object
        @storage[:statistics][:total] = @passed + @skipped + @failed + @errored
        @storage[:statistics][:failed] = @failed
        @storage[:statistics][:errored] = @errored
        @storage[:statistics][:skipped] = @skipped
        @storage[:statistics][:passed] = @passed

        # output JSON
        output($stdout, @storage)
      end

      def yellow?
        @skipped > 0 && !red? 
      end

      def green?
        !red? && !yellow?
      end

      def red?
        @failed +  @errored > 0
      end

      private

      def set_status
        if yellow?
          @storage[:status] = yellow_status
        elsif green?
          @storage[:status] = green_status
        end
      end

      def red_status
        {
          code: 'Failed',
          color: 'red'
        }
      end

      def yellow_status
        {
          code: 'Passed, with skipped tests',
          color: 'yellow'
        }
      end

      def green_status
        {
          code: 'Success',
          color: 'green'
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

      def fault_h(type, test, e)
        {
          type: type,
          class: test.class.name,
          name: test.name,
          message: e.message,
          location: location(e)
        }
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
        status('skipped', test, :skipped?) do |e|
          @storage[:skips] << e
          @skipped += 1
        end
      end

      def errored(test)
        status('error', test, :error?) do |e|
          @storage[:fails] << e
          @errored += 1
        end
      end

      def failed(test)
        status('failure', test, :failure) do |e|
          @storage[:fails] << e
          @failed += 1
        end
      end

      def passed(_test)
        @passed += 1
      end

      # I/O
      def output(io, body)
        io.write(JSON.dump(body))
      end
    end
  end
end
