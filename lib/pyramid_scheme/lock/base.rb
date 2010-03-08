module PyramidScheme
  module Lock
    class Base
      def exists?
        raise_override
      end

      def create
        raise_override
      end

      def destroy
        raise_override
      end
    end
  end
end
