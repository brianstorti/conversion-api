require "date"

class SearchParams
  DATE_FORMAT="YY-mm-dd"

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

    date = Date.parse(month, DATE_FORMAT)
    convert_date(date)
  end

  def find_time_range(end_date, month)
    return 30 if month
    return 7 if end_date
    return 1
  end

  def convert_date(date)
    return unless date

    base_date = Date.new(2009, 01, 01)
    (date - base_date).to_i
  end
end
