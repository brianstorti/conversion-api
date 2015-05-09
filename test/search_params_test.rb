require "date"
require "minitest/autorun"

require_relative "../lib/search_params"

class SearchParamsTest < Minitest::Test
  def test_creates_parameters
    params = SearchParams.new({ "metric_id" => 1,
                                "date" => Date.new(2014, 3, 1),
                                "end_date" => Date.new(2014, 3, 8) })

    start_date_john_time = 1885
    end_date_john_time = 1892

    assert_equal 1, params.metric_id
    assert_equal start_date_john_time, params.start_date
    assert_equal end_date_john_time, params.end_date
    assert_equal 7, params.time_range
  end
end
