require "date"

class SearchParams
  attr_reader :metric_id, :start_date, :end_date, :time_range

  def initialize(params)
    @metric_id = params["metric_id"]
    @start_date = convert_date(params["date"]) || convert_month(params["month"])
    @end_date = convert_date(params["end_date"])
    @time_range = find_time_range(params["end_date"], params["month"])
  end

  private
  def convert_month(month)
    return unless month

    date = Date.parse(month, "YY-mm-dd")
    convert_date(date)
  end

  def find_time_range(end_date, month)
    return 30 if month
    return 7 if end_date
    return 1
  end

  # Converts a date to the JohnTime format.
  # The JohnTime format is the number of days since Jan 1, 2009
  #
  # @param date [Date] the date to be converted
  # @return [Integer] number of days from Jan 1, 2009 to `date`
  def convert_date(date)
    return unless date

    base_date = Date.new(2009, 01, 01)
    (date - base_date).to_i
  end
end
