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
    @provider.retrieve_index
    @provider.copy_attempts.should eql(2)
  end

  it 'should raise an error if the server is stuck indexing' do
    Kernel.stub!(:sleep)
    @provider.stubs(:index_in_progress?).returns(true)
    lambda { @provider.retrieve_index }.should raise_error
  end

  it 'should copy all sphinx files from server source to server destination' do
    FileUtils.mkdir_p(PyramidScheme.configuration[:server_source_path])   
    FileUtils.mkdir_p(PyramidScheme.configuration[:server_destination_path])
    @filenames = [
      '.spi',
      '.spd',
      '.spa',
      '.sph',
      '.spm',
      '.spp'
    ].collect{|s| "some_index#{s}" }

    @filenames.each do |f|
      FileUtils.touch(File.join(PyramidScheme.configuration[:server_source_path], f))
      File.exists?(File.join(PyramidScheme.configuration[:server_source_path], f)).should be_true
    end

    @provider.process_index
    
    @filenames.each do |f|
      File.exists?(File.join(PyramidScheme.configuration[:server_destination_path], f)).should be_true
    end
  end
end

describe "copying from the filesytem" do
  include FakeFS::SpecHelpers

  before(:each) do
    @configuration = PyramidScheme::Configuration.new
    @provider = PyramidScheme::IndexProvider::FileSystem.new
    FileUtils.mkdir_p(@configuration[:client_source_path])
    FileUtils.mkdir_p(@configuration[:client_destination_path])

  end

  it 'should copy the files with .new extensions' do
    @filenames = [
      '.spi',
      '.spd',
      '.spa',
      '.sph',
      '.spm',
      '.spp'
    ].collect{|s| "some_index#{s}" }

    @filenames.each do |f|
      FileUtils.touch(File.join(PyramidScheme.configuration[:client_source_path], f))
      File.exists?(File.join(PyramidScheme.configuration[:client_source_path], f)).should be_true
    end

    @provider.retrieve_index

    @filenames.each do |f|
      new_filename = File.basename(f).gsub(/\./, ".new.")
      File.exists?(File.join(PyramidScheme.configuration[:client_destination_path], 
        new_filename)).should be_true
    end

  end
end

