module PyramidScheme
  class IndexServer
    attr_reader :indexer_class, :configuration, :index_provider
    
    # initializes a new index server
    # @param options [Hash] takes an optional :indexer_class (defaults to PyramidScheme::ThinkingSphinxIndexer 
    def initialize(options = {})
      @indexer_class = options[:indexer_class] || PyramidScheme::ThinkingSphinxIndexer
      @index_provider = PyramidScheme::IndexProvider::FileSystem.new
      @configuration = PyramidScheme::Configuration.new
    end

    # @returns [PyramidScheme::Indexer] an instance of the specified indexer_class from initialization
    def indexer
      @indexer ||= @indexer_class.new
    end

    # run the index
    def index
      create_lock_file
      indexer.index
      destroy_lock_file
      index_provider.process_index
    end

    private
      def create_lock_file
        PyramidScheme::IndexLockFile.create
      end

      def destroy_lock_file
        PyramidScheme::IndexLockFile.destroy
      end
  end
end
