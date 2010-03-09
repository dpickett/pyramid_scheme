require "ruby-debug"
module PyramidScheme
  module IndexProvider
    class S3 < PyramidScheme::IndexProvider::Base
      class << self
        def required_options
          [
            :access_key,
            :secret_access_key,
            :bucket,
            :prefix,
            :server_source_path,
            :client_destination_path
          ]
        end

        def connection
          @connection ||= RightAws::S3.new(
            PyramidScheme.configuration[:access_key],
            PyramidScheme.configuration[:secret_access_key]
          )
        end

        def bucket
          @bucket ||= RightAws::S3::Bucket.create(
            connection, PyramidScheme.configuration[:bucket]) 
        end
      end

      def initialize(options = {})
        super
      end

      def process_index
        server_copy
      end
      
      def provide_client_with_index
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          self.class.bucket.keys('prefix'=> @configuration[:prefix]).each do |obj|
            new_filename = File.basename(obj.name.gsub(@configuration[:prefix], '').gsub(/\./, ".new."))
            destined_path = File.join(@configuration[:client_destination_path], new_filename)
            File.open(destined_path, 'w') do |file|
              file.write obj.data
            end
          end
        end
      end

      def lock
        @lock ||= PyramidScheme::Lock::S3.new
      end
      
      private
      def server_copy
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          Dir[File.join(@configuration[:server_source_path], "*#{ext}")].each do |f|
            key = RightAws::S3::Key.create(self.class.bucket, 
              "#{@configuration[:prefix]}/#{File.basename(f)}")
            key.put(File.read(f))
          end
        end

      end
    end
  end
end
