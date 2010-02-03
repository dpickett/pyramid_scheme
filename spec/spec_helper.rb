$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pyramid_scheme'
require 'spec'
require 'spec/autorun'

require 'rubygems'
require 'mocha'

Spec::Runner.configure do |config|
  
end
