module PyramidScheme
  class Configuration
    INDEX_FILE_EXTENSIONS = [
      '.spa',
      '.spd',
      '.sph',
      '.spi',
      '.spm',
      '.spp',
      '.spk'
    ]

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

    def self.set_from_yml(path)
      config_hash = YAML::load(File.open(path))
      set do |config|
        config_hash.each do |key, value|
          config.send("#{key}=", value)
        end
      end
    end

    def self.defaults
      { 
        :lock_file_name       => 'pyramid_scheme_index_in_progress.txt',
        :index_provider_class => PyramidScheme::IndexProvider::FileSystem, 
        :indexer_class        => PyramidScheme::Indexer::ThinkingSphinx
      } 
    end

    def [](key)
      configatron.pyramid_scheme.to_hash[key] 
    end
  end
end
