module PyramidScheme
  module Lock
    class S3 < PyramidScheme::Lock::Base
      attr_reader :bucket

      def initialize
        @bucket = PyramidScheme::IndexProvider::S3.bucket
      end

      def exists?
        key = RightAws::S3::Key.create(bucket, key_name)
        key.exists?
      end

      def create
        key = RightAws::S3::Key.create(bucket, key_name)
        key.put("")
      end

      def destroy
        key = RightAws::S3::Key.create(bucket, key_name)
        key.delete
      end

      protected
      def key_name
        "#{PyramidScheme.configuration[:prefix]}/#{PyramidScheme.configuration[:lock_file_name]}"
      end
    end
  end
end
