require 'date'

class SearchParams
  attr_reader :start_date, :end_date, :time_range

  def initialize(params)
    @metric_id = params["metric_id"]
    @start_date = process_start_date(params["date"])
    @end_date = process_end_date(params["end_date"])
    @time_range = find_time_range(params["date"], params["end_date"])
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
  def process_start_date(date)
    return unless date

    year, month, day = date.split("-").map(&:to_i)
    day ||= 1
    john_time_format(year, month, day)
  end

  def process_end_date(end_date)
    return unless end_date

    year, month, day = end_date.split("-").map(&:to_i)
    john_time_format(year, month, day)
  end

  def find_time_range(date, end_date)
    return unless date

    return 7 if end_date
    return 30 if date.split("-").size == 2
    return 1
  end

  def john_time_format(year, month, day)
    date = Date.new(year, month, day)
    base_date = Date.new(2009, 01, 01)

    (date - base_date).to_i
  end
end
