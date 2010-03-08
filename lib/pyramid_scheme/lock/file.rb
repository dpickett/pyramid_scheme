module PyramidScheme
  module Lock
    class File < PyramidScheme::Lock::Base
      def exists?
        ::File.exists?(client_path)
      end

      def create
        FileUtils.touch(server_path)
      end 

      def destroy
        FileUtils.rm_f(server_path)
      end
      
      private
      def server_path
        ::File.join(PyramidScheme.configuration[:server_destination_path], 
          PyramidScheme.configuration[:lock_file_name])
      end

      def client_path
        ::File.join(PyramidScheme.configuration[:client_source_path], 
          PyramidScheme.configuration[:lock_file_name])
      end
    end
  end
end
