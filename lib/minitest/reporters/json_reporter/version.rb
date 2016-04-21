# version.rb - version constant: Minitest::Reporters::JsonReporter::VERSION

# MiniTest namespace - plugins must live here
module Minitest
  # Minitest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # Minitest Reporter that produces a JSON output for interface in IDEs, editor.
    class JsonReporter < BaseReporter
      VERSION = '0.1.1'.freeze
    end
  end
end
