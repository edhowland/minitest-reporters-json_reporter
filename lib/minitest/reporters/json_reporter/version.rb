# version.rb - version constant: MiniTest::Reporters::JsonReporter::VERSION

# MiniTest namespace - plugins must live here
module MiniTest
  # MiniTest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # MiniTest Reporter that produces a JSON output for interface in IDEs, editor.
    class JsonReporter < BaseReporter
      VERSION = '0.1.1'.freeze
    end
  end
end
