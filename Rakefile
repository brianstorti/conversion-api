require "./lib/api"

require "rake/testtask"
require "rubocop/rake_task"
require "sinatra/activerecord/rake"

task default: [:test, :rubocop]

RuboCop::RakeTask.new

Rake::TestTask.new("test") do |t|
  t.pattern = "test/*_test.rb"
end
