module PyramidScheme
  module Indexer
    class ThinkingSphinx < PyramidScheme::Indexer::Base
      def self.default_task_name
        'ts:in'
      end
    end
  end
end
