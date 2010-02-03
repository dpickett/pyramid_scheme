module PyramidScheme
  module IndexProvider
    class FileSystem
      REQUIRED_OPTIONS = [:source_path, :destination_path]
      attr_reader :configuration

      def initialize(options = {})
        @configuration = PyramidScheme::Configuration.new(options)
        ensure_required_options_are_present
      end

      def index_in_progress?
        PyramidScheme::IndexLockFile.exists?
      end

      private
        
        def ensure_required_options_are_present
          REQUIRED_OPTIONS.each do |opt|
            if configuration[opt].nil?
              raise PyramidScheme::RequiredConfigurationNotFound, "the #{opt} setting was not found"
            end
          end
        end
    end
  end
end
