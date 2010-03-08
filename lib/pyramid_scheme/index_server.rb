module PyramidScheme
  class IndexServer
    attr_reader :indexer_class, :configuration, :index_provider
    
    # initializes a new index server
    # @param options [Hash] takes an optional :indexer_class (defaults to PyramidScheme::ThinkingSphinxIndexer 
    def initialize(options = {})
      @configuration = PyramidScheme::Configuration.new
      @index_provider = @configuration[:index_provider_class].new
      @indexer_class = @configuration[:indexer_class]
    end

    # @returns [PyramidScheme::Indexer::Base] an instance of the specified indexer_class from initialization
    def indexer
      @indexer ||= @indexer_class.new
    end

    # run the index
    def index
      create_lock_file
      indexer.configure
      indexer.index
      destroy_lock_file
      index_provider.process_index
    end

    private
      def create_lock_file
        @index_provider.lock.create
      end

      def destroy_lock_file
        @index_provider.lock.destroy
      end
  end
end
