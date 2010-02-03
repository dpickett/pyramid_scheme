module PyramidScheme
  module IndexProvider
    class FileSystem
      MAXIMUM_COPY_ATTEMPTS = 5
      REQUIRED_OPTIONS = [:source_path, :destination_path]
      attr_reader :configuration, :copy_attempts

      def initialize(options = {})
        @configuration = PyramidScheme::Configuration.new(options)
        ensure_required_options_are_present
        @copy_attempts = 0
      end

      def index_in_progress?
        PyramidScheme::IndexLockFile.exists?
      end

      def copy
        if !exceeded_maximum_copy_attempts?
          attempt_to_copy
        else
          raise "copying sphinx indexes failed after maximum number of attempts"
        end
      end

      private
      def ensure_required_options_are_present
        REQUIRED_OPTIONS.each do |opt|
          if configuration[opt].nil?
            raise PyramidScheme::RequiredConfigurationNotFound, "the #{opt} setting was not found"
          end
        end
      end

      def attempt_to_copy
        @copy_attempts += 1
        if index_in_progress?
          Kernel.sleep(5)
          copy
        else
          #TODO - dp - actually implement provider copy 
        end
      end

      def exceeded_maximum_copy_attempts?
        copy_attempts > MAXIMUM_COPY_ATTEMPTS
      end
    end
  end
end
