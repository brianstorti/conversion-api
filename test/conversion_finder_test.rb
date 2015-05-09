require 'minitest/autorun'
require_relative '../lib/conversion_finder'
require_relative '../lib/search_params'

class ConversionFinderTest < Minitest::Test
  def test_finds_conversion_value
    finder = ConversionFinder.new("test/assets/test.csv")
    search_params = SearchParams.new({"metric_id" => "15", "date" => "2014-07-05"})

    assert_equal 9, finder.find(search_params)
  end
end
