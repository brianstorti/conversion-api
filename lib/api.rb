require "sinatra/base"
require "sinatra/param"
require "rack-cache"
require "json"

require_relative "search_params"
require_relative "conversion_finder"

class Api < Sinatra::Application
  configure do
    set :finder, ConversionFinder.new("assets/metrics_over_time_view.csv")
  end

  get "/conversion" do
    param :metric_id, Integer, required: true
    param :date, Date
    param :end_date, Date
    param :month, String,
          format: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/,
          transform: lambda { |date| "#{date}-01" }

    any_of :date, :month

    content_type :json
    cache_control :public, max_age: 60

    search_params = SearchParams.new(params)
    value = settings.finder.find(search_params)

    halt(404) if value.nil?

    response = { value: value }

    etag Digest::MD5.hexdigest(response.to_s)

    response.to_json
  end
end
