module PyramidScheme
  module Indexer
    #defines an interface for indexers
    class Base
      attr_reader :index_task_name, :configure_task_name

      def initialize
        @index_task_name = self.class.index_task_name
        @configure_task_name = self.class.configure_task_name
      end

      def configure
        Rake::Task[@configure_task_name].invoke
      end

      def index
        Rake::Task[@index_task_name].invoke
      end
    end
  end
end
