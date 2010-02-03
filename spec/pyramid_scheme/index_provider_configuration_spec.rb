require 'spec_helper'

describe PyramidScheme::Configuration do
  before(:each) do
    @source_path = '/some_mount_location'
    @destination_path = '/data/app/current/db/sphinx/production'
    PyramidScheme.configure do |config|
      config.source_path = @source_path
      config.destination_path = @destination_path
    end
  end

  it 'should use allow me to set global configuration options' do 
    @configuration = PyramidScheme::Configuration.new
    @configuration[:source_path].should eql(@source_path)
  end

  it 'should allow me to override configuration options' do
    @new_dest = '/some/other/path'
    @configuration = PyramidScheme::Configuration.new(
      :destination_path => @new_dest)
    @configuration[:destination_path].should eql(@new_dest)
  end

  it 'should set a default index lock file' do
    @configuration = PyramidScheme::Configuration.new
    @configuration[:lock_file_name].should_not be_nil
  end
end
