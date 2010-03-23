require 'spec_helper'

describe "S3 index provider" do
  before(:each) do
    load_configuration_from_yaml
    @provider = PyramidScheme::IndexProvider::S3.new
  end

  describe "lock files" do
    it 'should create a key in the s3 bucket and prefix' do
      PyramidScheme::Lock::S3.new.create
      PyramidScheme::Lock::S3.new.exists?.should be_true
    end

    it 'should remove a key in the s3 bucket and prefix' do
      PyramidScheme::Lock::S3.new.destroy
      PyramidScheme::Lock::S3.new.exists?.should be_false
    end
  end

  describe "populating index files" do
    before(:each) do

    end
    it 'should copy all the relevant index files to s3 on processing' do
      FileUtils.mkdir_p(PyramidScheme.configuration[:server_source_path])   
      FileUtils.mkdir_p(PyramidScheme.configuration[:server_destination_path])
      @filenames = [
        '.spi',
        '.spd',
        '.spa',
        '.sph',
        '.spm',
        '.spp',
        '.spk'
      ].collect{|s| "some_index#{s}" }

      @filenames.each do |f|
        FileUtils.touch(File.join(PyramidScheme.configuration[:server_source_path], f))
        File.exists?(File.join(PyramidScheme.configuration[:server_source_path], f)).should be_true
      end

      @provider.process_index
   
      @filenames.each do |f|
        AWS::S3::S3Object.exists?("#{PyramidScheme.configuration[:prefix]}/#{@filename}", 
          PyramidScheme.configuration[:bucket])
      end
    end
  end

  describe "providing index files" do
    it 'should download all the relevant index files to s3 on providing' do
      FileUtils.mkdir_p(PyramidScheme.configuration[:client_destination_path])
      @provider.retrieve_index

      [
        '.spi',
        '.spd',
        '.spa',
        '.sph',
        '.spm',
        '.spp',
        '.spk'
      ].collect{|s| "some_index#{s}" }.each do |f|
        File.exists?(File.join(PyramidScheme.configuration[:client_destination_path], 
          f.gsub(/\./, '.new.'))).should be_true
      end

    end
  end

  def load_configuration_from_yaml
    FakeFS.deactivate!
    
    PyramidScheme.configure do |config|
      config.index_provider_class = PyramidScheme::IndexProvider::S3
    end 

    PyramidScheme.configure_with_yml(File.join(File.dirname(__FILE__), 's3.yml'))
    FakeFS.activate!
  end
end
