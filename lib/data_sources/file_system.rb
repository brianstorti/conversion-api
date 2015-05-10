module DataSource
  class FileSystem
    def initialize(path = "assets/metrics_over_time_view.csv")
      @path = path
    end

    def content
      File.read(@path)
    end
  end
end
