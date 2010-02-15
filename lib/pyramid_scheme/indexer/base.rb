module PyramidScheme
  module Indexer
    #defines an interface for indexers
    class Base
      attr_reader :rake_task_name

      def initialize(rake_task_name = nil)
        @rake_task_name = rake_task_name || self.class.default_task_name
      end

      def index
        Rake::Task[@rake_task_name].invoke
      end
    end
  end
end
