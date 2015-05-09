require 'minitest/autorun'
require 'rack/test'

require_relative '../lib/api'

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api
  end

  def test_returns_success
    get '/conversion?metric_id=123'
    assert last_response.ok?
    assert_equal "so modular", last_response.body
  end

  def test_returns_bad_request_for_invalid_parameters
    get '/conversion'
    assert_equal 400, last_response.status
  end
end
