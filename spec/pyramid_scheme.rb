require 'spec_helper'

describe PyramidScheme do
  it 'should have a shorthand delegate for PyramidScheme::IndexConfiguration' do
    @path = '/a/path'

    PyramidScheme.configure do |config|
      config[:source_path] = @path
    end

    PyramidScheme::IndexProviderConfiguration.new[:source_path].should eql(@path)
  end
end
