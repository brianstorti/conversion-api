class SearchParams
  def initialize(params)
    @metric_id = params["metric_id"]
  end

  def validate!
    errors = []
    if @metric_id.nil?
      errors << { parameter: "metric_id", error: "required parameter" }
    end

    errors
  end
end
