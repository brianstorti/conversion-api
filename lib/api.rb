require "sinatra"
require "json"

require_relative "search_params"
require_relative "conversion_finder"

class Api < Sinatra::Application
  configure do
    set :csv_path, "assets/metrics_over_time_view.csv"
  end

  get "/conversion" do
    content_type "application/json"

    search_params = SearchParams.new(params)
    errors = search_params.validate!

    if errors.any?
      status 400
      return errors.to_json
    end

    finder = ConversionFinder.new(settings.csv_path)
    value = finder.find(search_params)

    { value: value }.to_json
  end
end
