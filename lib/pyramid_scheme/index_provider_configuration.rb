module PyramidScheme
  class IndexProviderConfiguration
    attr_reader :options

    def initialize(options = {})
      @options = configatron.pyramid_scheme.to_hash.merge(options)
    end 

    def self.set(&block)
      yield(configatron.pyramid_scheme)
    end

    def [](key)
      @options[key] || configatron.pyramid_scheme.to_hash[key]
    end
  end
end
