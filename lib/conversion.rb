require "sinatra/activerecord"

class Conversion < ActiveRecord::Base
  def self.find_for_params(search_params)
    conversion = where(metric_id: search_params.metric_id,
                       time_range_length: search_params.time_range,
                       start_date: search_params.start_date)

    if search_params.end_date
      conversion = conversion.where(end_date: search_params.end_date)
    end

    conversion.first.value if conversion.any?
  end
end
