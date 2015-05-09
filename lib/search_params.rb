require 'date'

class SearchParams
  DATE_FORMAT="YY-mm-dd"

  attr_reader :start_date, :end_date, :time_range

  def initialize(params)
    @metric_id = params["metric_id"]
    @start_date = process_date(params["date"]) || process_month(params["month"])
    @end_date = process_date(params["end_date"])
    @time_range = find_time_range(params["end_date"], params["month"])
  end

  def metric_id
    @metric_id.to_i
  end

  def validate!
    errors = []

    if @metric_id.nil?
      errors << { parameter: "metric_id", error: "required parameter" }
    end

    if @start_date.nil?
      errors << { parameter: "date", error: "required parameter (format: yyyy-mm or yyyy-mm-dd)" }
    end

    errors
  end

  private
  def process_date(date)
    return unless date

    date = Date.parse(date, DATE_FORMAT)
    john_time_format(date)
  end

  def process_month(month)
    return unless month

    default_day = "1"
    date = Date.parse("#{month}-#{default_day}", DATE_FORMAT)
    john_time_format(date)
  end

  def find_time_range(end_date, month)
    return 30 if month
    return 7 if end_date
    return 1
  end

  def john_time_format(date)
    base_date = Date.new(2009, 01, 01)

    (date - base_date).to_i
  end
end
