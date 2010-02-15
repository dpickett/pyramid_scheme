module PyramidScheme
  module Indexer
    class ThinkingSphinx < PyramidScheme::Indexer::Base
      def self.index_task_name
        'ts:in'
      end

      def self.configure_task_name
        'ts:config'
      end
    end
  end
end
