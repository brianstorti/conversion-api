require 'csv'

class ConversionFinder
  def initialize(location = "assets/metrics_over_time_view.csv")
    @location = location
  end

  def find(search_params)
    search = { 'metric_id' => search_params.metric_id,
               'time_range_length' => search_params.time_range,
               'start_date' => search_params.start_date }

    search['end_date'] = search_params.end_date if search_params.end_date

    result = ""
    options = { headers: true, converters: [ :numeric ] }

    CSV.open(@location, "r", options) do |csv|
      result = csv.find do |row|
        found = true
        search.keys.each do |key|
          found = found && row[key] == search[key]
        end

        found
      end
    end

    result["value"] if result
  end
end
