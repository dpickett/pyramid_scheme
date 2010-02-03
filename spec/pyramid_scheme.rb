require 'spec_helper'

describe PyramidScheme do
  it 'should have a shorthand delegate for setting the configuration' do
    @path = '/a/path'

    PyramidScheme.configure do |config|
      config[:source_path] = @path
    end

    PyramidScheme::Configuration.new[:source_path].should eql(@path)
  end
  
  it 'should have a shorthand delegate for getting the configuration' do
    PyramidScheme.configuration[:source_path].should eql(PyramidScheme::Configuration.new[:source_path])
  end
end
