module PyramidScheme
  module IndexProvider
    class FileSystem
      MAXIMUM_COPY_ATTEMPTS = 5
      REQUIRED_OPTIONS = [
        :server_source_path, 
        :server_destination_path,
        :client_source_path,
        :client_destination_path
      ]

      attr_reader :configuration, :copy_attempts

      def initialize(options = {})
        @configuration = PyramidScheme::Configuration.new(options)
        ensure_required_options_are_present
        @copy_attempts = 0
      end

      def index_in_progress?
        PyramidScheme::IndexLockFile.exists?
      end

      def process_index
        server_copy
      end

      def retrieve_index
        client_copy
      end

      private
      def server_copy
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          Dir[File.join(self.configuration[:server_source_path], "*#{ext}")].each do |f|
            FileUtils.cp_r(f, "#{self.configuration[:server_destination_path]}")
          end
        end
      end

      def client_copy
        if !exceeded_maximum_copy_attempts?
          attempt_to_copy
        else
          raise "copying sphinx indexes failed after maximum number of attempts"
        end
      end

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
          client_copy
        else
          copy_client_files
        end
      end

      def copy_client_files
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          Dir[File.join(self.configuration[:client_source_path], "*#{ext}")].each do |f|
            new_filename = File.basename(f.gsub(/\./, ".new."))
            FileUtils.cp_r(f, 
              "#{self.configuration[:client_destination_path]}/#{new_filename}")
          end
        end

      end

      def exceeded_maximum_copy_attempts?
        copy_attempts > MAXIMUM_COPY_ATTEMPTS
      end
    end
  end
end
