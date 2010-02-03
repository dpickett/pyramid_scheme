require 'spec_helper'

describe PyramidScheme::IndexProviderConfiguration do
  before(:each) do
    @source_path = '/some_mount_location'
    @destination_path = '/data/app/current/db/sphinx/production'
    PyramidScheme::IndexProviderConfiguration.set do |config|
      config.source_path = @source_path
      config.destination_path = @destination_path
    end
  end

  it 'should use allow me to set global configuration options' do 
    @configuration = PyramidScheme::IndexProviderConfiguration.new
    @configuration[:source_path].should eql(@source_path)
  end

  it 'should allow me to override configuration options' do
    @new_dest = '/some/other/path'
    @configuration = PyramidScheme::IndexProviderConfiguration.new(
      :destination_path => @new_dest)
    @configuration[:destination_path].should eql(@new_dest)
  end
end
