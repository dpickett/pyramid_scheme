module PyramidScheme
  class UltrasphinxIndexer < Indexer
    def self.default_task_name
      'ultrasphinx:index'
    end
  end
end
