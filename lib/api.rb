require "sinatra"
require "json"

require_relative "search_params"

class Api < Sinatra::Application
  get "/conversion" do
    content_type "application/json"

    search_params = SearchParams.new(params)
    errors = search_params.validate!

    if errors.any?
      status 400
      return errors.to_json
    end

    "so modular"
  end
end
