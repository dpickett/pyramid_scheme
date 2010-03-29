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

    def bounce_pids
      PyramidScheme::ProcessManager.bounce_searchd
    end
  end
end
