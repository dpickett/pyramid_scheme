$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pyramid_scheme'
require 'spec'
require 'spec/autorun'

require 'rubygems'
require 'mocha'
require 'fakefs'
require 'fakefs/spec_helpers'


Spec::Runner.configure do |config|
  config.before(:each) do
    PyramidScheme.configure do |config|
      config.index_provider_class = PyramidScheme::IndexProvider::FileSystem
      config.client_source_path = '/some/default/source'
      config.client_destination_path = '/some/default/destination'
      config.server_source_path = '/some/server/source'
      config.server_destination_path = '/some/server/destination'
    end
  end  
end

module FakeFS
  class File
    def size
      0
    end
  end
end
