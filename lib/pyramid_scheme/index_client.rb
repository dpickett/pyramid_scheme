module PyramidScheme
  class IndexClient
    attr_reader :index_provider
    def initialize(options = {})
      @index_provider = PyramidScheme::IndexProvider::FileSystem.new
    end
  end
end
