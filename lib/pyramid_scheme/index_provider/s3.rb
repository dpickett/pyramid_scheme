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

        def establish_connection!
          @connection ||= AWS::S3::Base.establish_connection!(
            :access_key_id => PyramidScheme.configuration[:access_key],
            :secret_access_key => PyramidScheme.configuration[:secret_access_key]
          )
        end

      end

      def initialize(options = {})
        super
        self.class.establish_connection!
      end

      def process_index
        server_copy
      end

      def provide_client_with_index
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          AWS::S3::Bucket.objects(@configuration[:bucket], 
            :prefix => "#{@configuration[:prefix]}/").each do |obj|
              
            new_filename = File.basename(obj.key.gsub("#{@configuration[:prefix]}/", '').gsub(/\./, ".new."))
            destined_path = File.join(@configuration[:client_destination_path], new_filename)
            File.open(destined_path, 'w') do |file|
              AWS::S3::S3Object.stream(obj.key, @configuration[:bucket]) do |chunk|
                file.write chunk
              end
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
            AWS::S3::S3Object.store("#{@configuration[:prefix]}/#{File.basename(f)}",
              File.open(f),
              @configuration[:bucket]
            )
          end
        end

      end
    end
  end
end
