require 'date'
require 'minitest/autorun'
require_relative '../lib/search_params'

class SearchParamsTest < Minitest::Test
  def test_validates_required_metric_id
    params = SearchParams.new({})
    errors = params.validate!

    assert_equal [{parameter: "metric_id", error: "required parameter"}], errors
  end

  def test_creates_parameters
    params = SearchParams.new({ "metric_id" => "1",
                                "date" => "2014-03-01",
                                "end_date" => "2014-03-8" })

    start_date_john_time = 1885
    end_date_john_time = 1892

    assert_equal 1, params.metric_id
    assert_equal start_date_john_time, params.start_date
    assert_equal end_date_john_time, params.end_date
    assert_equal 7, params.time_range
  end
end
