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
      self.defaults.each do |key, value|
        if configatron.pyramid_scheme.send("#{key}").nil? || configatron.pyramid_scheme.send("#{key}") == ""
          configatron.pyramid_scheme.send("#{key}=", value)
        end
      end
      yield(configatron.pyramid_scheme)
    end

    def self.set_from_yml(path)
      config_hash = YAML::load(File.open(path))
      set do |config|
        config_hash.each do |key, value|
          if key =~ /class$/
            config.send("#{key}=", recursive_const_get(value))
          else
            config.send("#{key}=", value)
          end
        end
      end
    end

    def self.defaults
      { 
        :lock_file_name       => 'pyramid_scheme_index_in_progress.txt',
        :index_provider_class => PyramidScheme::IndexProvider::FileSystem, 
        :indexer_class        => PyramidScheme::Indexer::ThinkingSphinx,
        :permit_server_daemon => true
      } 
    end

    def [](key)
      configatron.pyramid_scheme.to_hash[key] 
    end

    def self.recursive_const_get(klass_str, mod_base = Kernel)
      first_namespace = klass_str[/^\w*\:\:/]
      if first_namespace.nil?
        mod_base.const_get(klass_str)
      else
        recursive_const_get(klass_str.gsub(first_namespace, ""),
          mod_base.const_get(first_namespace[0..-3]))
      end
    end
  end
end
