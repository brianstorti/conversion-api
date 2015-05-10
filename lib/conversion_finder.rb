require "csv"

require_relative "data_sources/file_system"

class ConversionFinder
  def initialize(source = DataSource::FileSystem.new)
    @source = source
  end

  # Runs through the csv file trying to find a match
  # for `search_params`.
  #
  # @param search_param [SearchParam] the parameters used to build the search
  # @return [Numeric] conversion value that was found
  def find(search_params)
    search = { "metric_id" => search_params.metric_id,
               "time_range_length" => search_params.time_range,
               "start_date" => search_params.start_date }

    search["end_date"] = search_params.end_date if search_params.end_date

    result = find_row(search)

    result["value"] if result
  end

  private

  def find_row(search)
    options = { headers: true, converters: [:numeric] }

    CSV.parse(@source.content, options) do |row|
      found = true
      search.keys.each do |key|
        found &&= row[key] == search[key]
      end

      return row if found
    end
  end
end
