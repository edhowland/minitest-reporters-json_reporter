# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Must hard code the exact version number because of circular dependency
Gem::Specification.new do |spec|
  spec.name          = 'minitest-reporters-json_reporter'
  spec.version       = '0.9.9'
  spec.authors       = ['edhowland']
  spec.email         = ['ed.howland@gmail.com']

  spec.summary       = 'JSON Reporter format for minitest-reporters gem.'
  spec.description   = '    Formats the output of a Minitest run as JSON. Useful for interfacing Minitest or MiniSpec to IDEs or programming text editors, such as the Atom editor.
See: https://atom.io. Originally written to interface with the Viper Audible editor for blind programmers. See https://github.com/edhowland/viper'
  spec.homepage      = 'https://github.com/edhowland/minitest-reporters-json_reporter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.0'

  spec.add_runtime_dependency 'minitest-reporters', '~> 1.1', '>= 1.1.8'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
