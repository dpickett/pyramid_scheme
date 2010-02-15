module PyramidScheme
  module Indexer
    class Ultrasphinx < PyramidScheme::Indexer::Base
      def self.index_task_name
        'ultrasphinx:index'
      end

      def self.configure_task_name
        'ultrasphinx:configure'
      end
    end
  end
end
