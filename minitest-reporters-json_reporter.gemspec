# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/reporters'

require 'minitest/reporters/json_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-reporters-json_reporter"
  spec.version       = Minitest::Reporters::JsonReporter::VERSION
  spec.authors       = ["edhowland"]
  spec.email         = ["ed.howland@gmail.com"]

  spec.summary       = %q{JSON Reporter format for minitest-reporters gem.}
  spec.description   = %q{    Formats the output of a MiniTest run as JSON. Useful for interfacing MiniTest or MiniSpec to IDEs or programming text editors, such as the Atom editor. 
See: https://atom.io. Originally written to interface with the Viper Audible editor for blind programmers. See https://github.com/edhowland/viper}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'minitest', "~> 5.7"
  spec.add_runtime_dependency 'minitest-reporters', "~> 1.1.8"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
