require "minitest/autorun"
require "database_cleaner"

require_relative "test_helper"
require_relative "../lib/db_conversion_finder"
require_relative "../lib/search_params"

DatabaseCleaner.strategy = :transaction

class DBConversionFinderTest < Minitest::Test
  def setup
    DatabaseCleaner.start

    Conversion.create!(metric_id: 15, start_date: 2011, end_date: 2011,
                       time_range_length: 1, value: 1)

    Conversion.create!(metric_id: 15, start_date: 2011, end_date: 2018,
                       time_range_length: 7, value: 2)

    Conversion.create!(metric_id: 15, start_date: 2007,
                       time_range_length: 30, value: 3)
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_finds_conversion_value_for_specific_date
    search_params = SearchParams.new("metric_id" => 15,
                                     "date" => Date.new(2014, 7, 5))

    assert_equal 1, DBConversionFinder.new.find(search_params)
  end

  def test_finds_conversion_value_date_range
    search_params = SearchParams.new("metric_id" => 15,
                                     "date" => Date.new(2014, 7, 5),
                                     "end_date" => Date.new(2014, 7, 12))

    assert_equal 2, DBConversionFinder.new.find(search_params)
  end

  def test_finds_conversion_value_for_month
    search_params = SearchParams.new("metric_id" => 15,
                                     "month" => "2014-07-01")

    assert_equal 3, DBConversionFinder.new.find(search_params)
  end
end
