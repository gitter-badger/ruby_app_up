
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['bin/ruby_app_up', 'lib/**/*.rb', 'spec/**/*_spec.rb']
  task.formatters = ['simple', 'd']
  task.fail_on_error = true
end

task :default => [:spec, :rubocop]
