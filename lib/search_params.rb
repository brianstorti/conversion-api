require "date"

class SearchParams
  attr_reader :metric_id, :params

  private :params

  def initialize(params)
    @metric_id = params["metric_id"]
    @params = params
  end

  def start_date
    convert_date(params["date"]) || convert_month(params["month"])
  end

  def end_date
    convert_date(params["end_date"])
  end

  def time_range
    return 7 if params["end_date"]
    return 1 if params["date"]
    30
  end

  private

  def convert_month(month)
    return unless month

    date = Date.parse(month, "YY-mm-dd")
    convert_date(date)
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
