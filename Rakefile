# Rakefile - tasks for minitest-reporters-json_reporter gem
require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = './test/*_spec.rb'
end

task :yard do
  sh 'yardoc -o ./doc'
end
