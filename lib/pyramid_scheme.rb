require 'rubygems'
require 'rake'
require 'rake/tasklib'

require 'configatron'
require 'aws/s3'

require 'pyramid_scheme/required_configuration_not_found'

require 'pyramid_scheme/indexer/base'
require 'pyramid_scheme/indexer/thinking_sphinx'
require 'pyramid_scheme/indexer/ultrasphinx'
require 'pyramid_scheme/configuration'

require 'pyramid_scheme/index_provider/base'
require 'pyramid_scheme/index_provider/file_system'
require 'pyramid_scheme/index_provider/s3'

require 'pyramid_scheme/lock/base'
require 'pyramid_scheme/lock/file'
require 'pyramid_scheme/lock/s3'

require 'pyramid_scheme/index_server'

require 'pyramid_scheme/index_client'

require 'pyramid_scheme/tasks'

module PyramidScheme
  def self.configure(&block)
    PyramidScheme::Configuration.set(&block)
  end

  def self.configure_with_yml(path)
    PyramidScheme::Configuration.set_from_yml(path)
  end

  def self.configuration
    PyramidScheme::Configuration.new
  end
end
