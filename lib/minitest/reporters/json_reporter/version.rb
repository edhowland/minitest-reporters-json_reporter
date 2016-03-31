# version.rb - version constant: MiniTest::Reporters::JsonReporter::VERSION

# MiniTest namespace - plugins must live here
module MiniTest
  # MiniTest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # JsonReporter - MiniTest Reporter that produces a JSON output for interface in IDEs, editor.
    # See the Viper Audible editor for Blind Programmers: https://github.com/edhowland/viper
    class JsonReporter < BaseReporter
      VERSION = '0.1.0'.freeze
    end
  end
end
