require 'rubygems'
require 'rake'
require 'configatron'

require 'pyramid_scheme/indexer'
require 'pyramid_scheme/thinking_sphinx_indexer'
require 'pyramid_scheme/ultrasphinx_indexer'

require 'pyramid_scheme/index_provider_configuration'
require 'pyramid_scheme/index_provider/file_system'

require 'pyramid_scheme/index_server'

require 'pyramid_scheme/index_client'

module PyramidScheme
  def configure(&block)
    PyramidScheme::IndexProviderConfiguration.set(block)
  end
end
