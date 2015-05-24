require "./lib/api"

require "rake/testtask"
require "rubocop/rake_task"
require "sinatra/activerecord/rake"

task default: [:test, :rubocop]

RuboCop::RakeTask.new

Rake::TestTask.new("test") do |t|
  t.pattern = "test/*_test.rb"
end

task :import_csv do
  file_path = File.join(File.dirname(__FILE__),
                        "assets",
                        "metrics_over_time_view.csv")

  sql = %{COPY conversions(metric_id,
                            start_date,
                            time_range_length,
                            value,
                            last_calculated_at,
                            end_date)
           FROM '#{file_path}' DELIMITER ',' CSV HEADER}

  ActiveRecord::Base.connection.execute(sql)
end
