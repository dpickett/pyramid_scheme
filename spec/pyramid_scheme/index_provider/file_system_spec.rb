require 'spec_helper'

describe PyramidScheme::IndexProvider::FileSystem do
  before(:each) do
    @provider = PyramidScheme::IndexProvider::FileSystem.new
  end
  include FakeFS::SpecHelpers

  it 'should have a configuration' do
    @provider.configuration.should_not be_nil 
  end

  [
    :server_source_path,
    :server_destination_path,
    :client_source_path,
    :client_destination_path
  ].each do |option|
    it "should require the #{option} configuration option" do
      PyramidScheme.configure do |config|
        config.send("#{option}=", nil)
      end

      lambda { PyramidScheme::IndexProvider::FileSystem.new
        }.should raise_error(PyramidScheme::RequiredConfigurationNotFound)
    end
  end

  it 'should indicate that an index is in process if a lock file is present' do
    @configuration = PyramidScheme::Configuration.new
    FileUtils.mkdir_p(@configuration[:client_source_path])
    FileUtils.touch(File.join(
      @configuration[:client_source_path], @configuration[:lock_file_name]))
    @provider.index_in_progress?.should be_true
  end

  it 'should sleep if the server is still indexing' do
    @provider.stubs(:index_in_progress?).returns(true).then.returns(false)
    Kernel.expects(:sleep).once
    @provider.copy
    @provider.copy_attempts.should eql(2)
  end

  it 'should raise an error if the server is stuck indexing' do
    Kernel.stub!(:sleep)
    @provider.stubs(:index_in_progress?).returns(true)
    lambda { @provider.copy }.should raise_error
  end

end

describe "copying from the filesytem" do
  it 'should copy the files with .new extensions'
end

