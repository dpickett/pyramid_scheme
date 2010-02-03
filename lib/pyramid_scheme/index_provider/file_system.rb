module PyramidScheme
  module IndexProvider
    class FileSystem
      attr_reader :configuration

      def initialize(options = {})
        @configuration = PyramidScheme::IndexProviderConfiguration.new(options)
      end
    end
  end
end
