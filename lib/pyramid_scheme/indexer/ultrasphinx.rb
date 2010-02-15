module PyramidScheme
  module Indexer
    class Ultrasphinx < PyramidScheme::Indexer::Base
      def self.default_task_name
        'ultrasphinx:index'
      end
    end
  end
end
