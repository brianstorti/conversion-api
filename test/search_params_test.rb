require 'minitest/autorun'
require_relative '../lib/search_params'

class SearchParamsTest < Minitest::Test
  def test_validates_required_metric_id
    params = SearchParams.new({})
    errors = params.validate!

    assert_equal [{parameter: "metric_id", error: "required parameter"}], errors
  end
end
