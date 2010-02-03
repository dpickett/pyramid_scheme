module PyramidScheme
  class ThinkingSphinxIndexer < PyramidScheme::Indexer
    def self.default_task_name
      'ts:in'
    end
  end
end
