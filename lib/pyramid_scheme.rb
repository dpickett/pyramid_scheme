require 'rubygems'
require 'rake'
require 'configatron'

require 'pyramid_scheme/required_configuration_not_found'

require 'pyramid_scheme/indexer'
require 'pyramid_scheme/thinking_sphinx_indexer'
require 'pyramid_scheme/ultrasphinx_indexer'

require 'pyramid_scheme/index_lock_file'
require 'pyramid_scheme/configuration'
require 'pyramid_scheme/index_provider/file_system'

require 'pyramid_scheme/index_server'

require 'pyramid_scheme/index_client'

module PyramidScheme
  def self.configure(&block)
    PyramidScheme::Configuration.set(&block)
  end

  def self.configuration
    PyramidScheme::Configuration.new
  end
end
