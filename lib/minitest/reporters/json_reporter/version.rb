# version.rb - version constant: Minitest::Reporters::JsonReporter::VERSION

# Minitest namespace - plugins must live here
module Minitest
  # Minitest::Reporters from minitest-reporters gem: See: https://github.com/kern/minitest-reporters
  module Reporters
    # Minitest Reporter that produces a JSON output for interface in IDEs, editor.
    class JsonReporter < BaseReporter
      ##
      # Version of the Minitest::Reporters::JsonReporter gem.
      VERSION = '0.9.4'.freeze
    end
  end
end
