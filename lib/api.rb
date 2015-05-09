require "sinatra/base"
require "rack-cache"
require "json"

require_relative "search_params"
require_relative "conversion_finder"

class Api < Sinatra::Application
  configure do
    set :csv_path, "assets/metrics_over_time_view.csv"
  end

  get "/conversion" do
    content_type "application/json"
    cache_control :public, max_age: 60

    search_params = SearchParams.new(params)
    errors = search_params.validate!

    halt(400, errors.to_json) if errors.any?

    finder = ConversionFinder.new(settings.csv_path)
    value = finder.find(search_params)

    halt(404) if value.nil?

    response = { value: value }

    etag Digest::MD5.hexdigest(response.to_s)

    response.to_json
  end
end
