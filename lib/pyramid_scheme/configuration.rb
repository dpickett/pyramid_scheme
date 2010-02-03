module PyramidScheme
  class Configuration
    def initialize(options = {})
      self.class.set do |config|
        options.each do |key, value|
          config.send("#{key}=", value)
        end
      end
    end 

    def self.set(&block)
      yield(configatron.pyramid_scheme)
      defaults.each do |key, value|
        configatron.pyramid_scheme.send("#{key}=", value) unless configatron.pyramid_scheme.to_hash[key]
      end
    end

    def self.defaults
      { :lock_file_name => 'pyramid_scheme_index_in_progress.txt' } 
    end

    def [](key)
      configatron.pyramid_scheme.to_hash[key] 
    end
  end
end
