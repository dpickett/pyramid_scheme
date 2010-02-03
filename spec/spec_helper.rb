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
      config.source_path = '/some/default/source'
      config.destination_path = '/some/default/destination'
    end
  end  
end
