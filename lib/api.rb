require "sinatra/base"
require 'sinatra/param'
require "rack-cache"
require "json"

require_relative "search_params"
require_relative "conversion_finder"

class Api < Sinatra::Application
  configure do
    set :csv_path, "assets/metrics_over_time_view.csv"
  end

  get "/conversion" do
    param :metric_id, Integer, required: true
    param :date, Date
    param :end_date, Date
    param :month, String,
          format: /[0-9]4-[0-9]2/,
          transform: lambda { |date| "#{date}-01" }

    one_of :date, :month
    any_of :date, :month

    content_type :json
    cache_control :public, max_age: 60

    search_params = SearchParams.new(params)
    finder = ConversionFinder.new(settings.csv_path)
    value = finder.find(search_params)

    halt(404) if value.nil?

    response = { value: value }

    etag Digest::MD5.hexdigest(response.to_s)

    response.to_json
  end
end
