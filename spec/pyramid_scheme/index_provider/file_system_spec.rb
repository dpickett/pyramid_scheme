require 'spec_helper'

describe PyramidScheme::IndexProvider::FileSystem do
  before(:each) do
    @provider = PyramidScheme::IndexProvider::FileSystem.new
  end

  it 'should have a configuration' do
    @provider.configuration.should_not be_nil 
  end

  [
    :source_path,
    :destination_path
  ].each do |option|
    it "should require the #{option} configuration option" do
      PyramidScheme.configure do |config|
        config.send("#{option}=", nil)
      end

      lambda { PyramidScheme::IndexProvider::FileSystem.new
        }.should raise_error(PyramidScheme::RequiredConfigurationNotFound)
    end
  end

  it 'should have a method that verifies if an index is in process' do
    @provider.index_in_progress?.should be_false
  end
end

describe "copying from the filesytem" do
  it 'should copy the files with .new extensions'
end

