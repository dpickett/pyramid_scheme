module PyramidScheme
  module IndexProvider
    class FileSystem < IndexProvider::Base
      class << self 
        def required_options
          [
            :server_source_path, 
            :server_destination_path,
            :client_source_path,
            :client_destination_path
          ]
        end
      end

      def process_index
        server_copy
      end
      
      def lock
        @lock ||= PyramidScheme::Lock::File.new
      end
 
      def provide_client_with_index
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          Dir[File.join(self.configuration[:client_source_path], "*#{ext}")].each do |f|
            new_filename = File.basename(f.gsub(/\./, ".new."))
            FileUtils.cp_r(f, 
              "#{self.configuration[:client_destination_path]}/#{new_filename}")
          end
        end
      end

      private
      def server_copy
        Configuration::INDEX_FILE_EXTENSIONS.each do |ext|
          Dir[File.join(self.configuration[:server_source_path], "*#{ext}")].each do |f|
            FileUtils.cp_r(f, "#{self.configuration[:server_destination_path]}")
          end
        end
      end 
    end
  end
end
