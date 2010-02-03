module PyramidScheme
  class IndexClient
    MAXIMUM_COPY_ATTEMPTS = 5

    attr_reader :index_provider, :copy_attempts
    def initialize(options = {})
      @index_provider = PyramidScheme::IndexProvider::FileSystem.new
      @copy_attempts = 0
    end

    def copy
      if !exceeded_maximum_copy_attempts?
        attempt_to_copy
      else
        raise "copying sphinx indexes failed after maximum number of attempts"
      end
    end

    private
      def attempt_to_copy
        @copy_attempts += 1
        if index_provider.index_in_progress?
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
