module PyramidScheme
  class IndexClient
    attr_reader :index_provider
    def initialize(options = {})
      @configuration = PyramidScheme::Configuration.new(options)
      @index_provider = @configuration[:index_provider_class].new
    end

    def retrieve_index
      @index_provider.retrieve_index
      bounce_pids
    end

    def searchd_pids
      Rush.processes.filter(:cmdline => /searchd/)
    end

    def bounce_pids
      searchd_pids.each do |process|
        begin
          Process.kill("HUP", process.pid) 
        rescue Exception => e
          raise e unless e.message =~ /No such process/i
        end
      end
    end

  end
end
