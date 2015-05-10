require "sinatra/base"
require "sinatra/param"
require "rack-cache"
require "json"

require_relative "search_params"
require_relative "conversion_finder"

class Api < Sinatra::Application
  configure do
    set :finder, ConversionFinder.new
  end

  # GET /conversion?metric_id=123&month=2015-03
  # GET /conversion?metric_id=123&date=2015-12-01
  # GET /conversion?metric_id=123&date=2015-12-01&end_date=2015-12-08
  get "/conversion" do
    param :metric_id, Integer, required: true
    param :date, Date
    param :end_date, Date
    param :month, String,
          format: /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/,
          transform: ->(date) { "#{date}-01" }

    any_of :date, :month

    content_type :json
    cache_control :public, max_age: 60

    search_params = SearchParams.new(params)
    value = settings.finder.find(search_params)

    halt(404) unless value

    response = { value: value }

    etag Digest::MD5.hexdigest(response.to_s)

    response.to_json
  end
end
