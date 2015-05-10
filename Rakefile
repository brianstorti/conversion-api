require "rake/testtask"
require "rubocop/rake_task"

task default: [:test, :rubocop]

RuboCop::RakeTask.new

Rake::TestTask.new("test") do |t|
  t.pattern = "test/*_test.rb"
end
