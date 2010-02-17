module PyramidScheme
  class IndexClient
    attr_reader :index_provider
    def initialize(options = {})
      @index_provider = PyramidScheme::IndexProvider::FileSystem.new
    end

    def retrieve_index
      @index_provider.retrieve_index
      bounce_pids
    end

    def searchd_pids
      ps_output = `ps ax | grep searchd`
      ps_output.split("\n").collect{|p| /^\s*(\d*)/.match(p)[1]}
    end

    def bounce_pids
      searchd_pids.each do |pid|
        Process.kill("HUP", pid.to_i) if pid != ""
      end
    end

  end
end
