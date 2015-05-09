require 'minitest/autorun'

require_relative '../lib/conversion_finder'
require_relative '../lib/search_params'

class ConversionFinderTest < Minitest::Test
  def test_finds_conversion_value_for_specific_date
    search_params = SearchParams.new({"metric_id" => "15",
                                      "date" => "2014-07-05"})

    assert_equal 1, finder.find(search_params)
  end

  def test_finds_conversion_value_for_week
    search_params = SearchParams.new({"metric_id" => "30",
                                      "date" => "2014-07-07",
                                      "end_date" => "2014-07-13"})

    assert_equal 4, finder.find(search_params)
  end

  def test_finds_conversion_value_for_month
    search_params = SearchParams.new({"metric_id" => "15",
                                      "month" => "2014-07"})

    assert_equal 5, finder.find(search_params)
  end

  private
  def finder
    ConversionFinder.new("test/assets/test.csv")
  end
end
