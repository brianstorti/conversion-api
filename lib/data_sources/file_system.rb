# The idea is that we can switch between different datasources easily.
# As long as it responds to `content` with a csv, it doesn't matter if this
# csvis comming from a the local file system, from a database, or an external
# service.

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
