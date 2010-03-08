module PyramidScheme
  module Lock
    class S3 < PyramidScheme::Lock::Base
      def initialize
        PyramidScheme::IndexProvider::S3.establish_connection!
      end

      def exists?
        AWS::S3::S3Object.exists?(key_name, bucket)
      end

      def create
        AWS::S3::S3Object.store(key_name, "", bucket)
      end

      def destroy
        AWS::S3::S3Object.delete(key_name, bucket)
      end

      protected
      def bucket
        PyramidScheme.configuration[:bucket]
      end

      def key_name
        "#{PyramidScheme.configuration[:prefix]}/#{PyramidScheme.configuration[:lock_file_name]}"
      end
    end
  end
end
