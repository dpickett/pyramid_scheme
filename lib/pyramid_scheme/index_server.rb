module PyramidScheme
  class IndexServer
    attr_reader :indexer_class
    
    # initializes a new index server
    # @param options [Hash] takes an optional :indexer_class (defaults to PyramidScheme::ThinkingSphinxIndexer 
    def initialize(options = {})
      @indexer_class = options[:indexer_class] || PyramidScheme::ThinkingSphinxIndexer
    end

    # @returns [PyramidScheme::Indexer] an instance of the specified indexer_class from initialization
    def indexer
      @indexer ||= @indexer_class.new
    end

    # run the index
    def index
      indexer.index
    end
  end
end
