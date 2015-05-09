require 'minitest/autorun'
require 'rack/test'

require_relative '../lib/api'

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api.set :csv_path, "test/assets/test.csv"
  end

  def test_returns_success
    get '/conversion?metric_id=123&date=2014-07-05'
    assert_equal 200, last_response.status
  end

  def test_returns_bad_request_for_invalid_parameters
    get '/conversion'
    assert_equal 400, last_response.status
  end
end
