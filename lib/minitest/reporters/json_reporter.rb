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
        @storage = {
          status: {
            code: 'Failed',
            color: 'red'
          },
          metadata: {
            generated_by: self.class.name,
            version: MiniTest::Reporters::JsonReporter::VERSION,
            time: Time.now.utc.iso8601
          },
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

      private

      def set_status
        green = (@skipped.zero? && @failed.zero? && @errored.zero?)
        yellow = (@skipped > 0 && @failed.zero? && @errored.zero?)
        red = (@failed > 0 || @errored > 0)

        if yellow
          @storage[:status][:color] = 'yellow'
          @storage[:status][:code] = 'Passed with skipped tests'
        elsif green
          @storage[:status][:color] = 'green'
          @storage[:status][:code] = 'Success'
        end
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
        status('skipped', test, :skipped?) { |e| @storage[:skips] << e; @skipped += 1 }
      end

      def errored(test)
        status('error', test, :error?) { |e| @storage[:fails] << e; @errored += 1 }
      end

      def failed(test)
        status('failure', test, :failure) { |e| @storage[:fails] << e; @failed += 1 }
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
