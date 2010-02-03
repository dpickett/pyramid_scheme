require 'spec_helper'

describe PyramidScheme::IndexProvider::FileSystem do
  before(:each) do
    @provider = PyramidScheme::IndexProvider::FileSystem.new
  end

  it 'should have a configuration' do
    @provider.configuration.should_not be_nil 
  end

  it 'should have require source path configuration option'
  it 'should have a destination path configuration option'
  it 'should have a get method that retrieves the indexes'

end
 
