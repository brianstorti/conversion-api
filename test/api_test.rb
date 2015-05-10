require "minitest/autorun"
require "rack/test"

require_relative 'test_helper'
require_relative "../lib/api"

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api
  end

  def setup
    finder_stub = Minitest::Mock.new
    to_return_1 = 1
    when_called_with_any_param = [SearchParams]

    finder_stub.expect(:find, to_return_1, when_called_with_any_param)

    Api.set :finder, finder_stub
  end

  def test_finds_conversion
    get "/conversion?metric_id=15&date=2014-07-05"

    assert_equal 200, last_response.status

    response = { value: 1 }
    assert_equal response.to_json, last_response.body
  end

  def test_adds_cache_headers
    get "/conversion?metric_id=15&date=2014-07-05"

    assert_equal "public, max-age=60", last_response.header["Cache-Control"]
    assert !last_response.header["Etag"].nil?
  end

  def test_returns_not_found_status
    finder = Minitest::Mock.new
    finder.expect(:find, nil, [SearchParams])
    Api.set :finder, finder

    get "/conversion?metric_id=123&date=2014-07-05"
    assert_equal 404, last_response.status
  end

  def test_returns_bad_request_for_missing_metric_id
    get "/conversion"
    assert_equal 400, last_response.status
  end

  def test_returns_bad_request_for_missing_date_or_month
    get "/conversion?metric_id=1"
    assert_equal 400, last_response.status
  end

  def test_returns_bad_request_for_invalid_date
    get "/conversion?metrid_id=1&date=foo"
    assert_equal 400, last_response.status
  end

  def test_returns_bad_request_for_invalid_end_date
    get "/conversion?metrid_id=1&date=2011-01-01&end_date=foo"
    assert_equal 400, last_response.status
  end

  def test_returns_bad_request_for_invalid_month
    get "/conversion?metrid_id=1&month=foo"
    assert_equal 400, last_response.status
  end

  def test_returns_bad_request_for_date_and_month_in_the_same_request
    get "/conversion?metrid_id=1&month=2011-01&date=2011-02-02"
    assert_equal 400, last_response.status
  end
end
