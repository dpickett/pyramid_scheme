module PyramidScheme
  module IndexProvider
    class Base
      class << self
        def maximum_copy_attempts
          5
        end

        def required_options
          []
        end
      end

      attr_reader :configuration, :copy_attempts

      def initialize(options = {})
        @configuration = PyramidScheme::Configuration.new(options)
        ensure_required_options_are_present
        @copy_attempts = 0
      end

      def index_in_progress?
        raise_override
      end

      def process_index
        raise_override
      end

      def provide_client_with_index
        raise_override
      end
      
      def lock
        raise_override
      end

      def retrieve_index
        client_copy
      end

      def index_in_progress?
        lock.exists?
      end
      
      protected
      def ensure_required_options_are_present
        self.class.required_options.each do |opt|
          if @configuration[opt].nil? || @configuration[opt] == ''
            raise PyramidScheme::RequiredConfigurationNotFound, 
              "the #{opt} setting was not found"
          end
        end
      end

      def attempt_to_copy
        @copy_attempts += 1
        if index_in_progress?
          Kernel.sleep(5)
          retrieve_index
        else
          provide_client_with_index
        end
      end

      def client_copy
        if !exceeded_maximum_copy_attempts?
          attempt_to_copy
        else
          raise "copying sphinx indexes failed after maximum number of attempts"
        end
      end


      def exceeded_maximum_copy_attempts?
        copy_attempts > self.class.maximum_copy_attempts
      end


      private
      def raise_override
        raise "you must override this function"
      end

    end
  end
end
