require "minitest/autorun"

require_relative 'test_helper'
require_relative "../lib/conversion_finder"
require_relative "../lib/search_params"

class ConversionFinderTest < Minitest::Test
  def finder
    source = DataSource::FileSystem.new("test/assets/test.csv")
    ConversionFinder.new(source)
  end

  def test_finds_conversion_value_for_specific_date
    search_params = SearchParams.new({ "metric_id" => 15,
                                       "date" => Date.new(2014, 7, 5) })

    assert_equal 1, finder.find(search_params)
  end

  def test_finds_conversion_value_date_range
    search_params = SearchParams.new({"metric_id" => 30,
                                      "date" => Date.new(2014, 7, 7),
                                      "end_date" => Date.new(2014, 7, 13)})

    assert_equal 4, finder.find(search_params)
  end

  def test_finds_conversion_value_for_month
    search_params = SearchParams.new({"metric_id" => 15,
                                      "month" => "2014-07-01"})

    assert_equal 5, finder.find(search_params)
  end
end
