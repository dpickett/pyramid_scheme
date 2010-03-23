require 'spec_helper'

describe PyramidScheme::Configuration do
  describe "from yml" do
    before(:each) do
      FakeFS.deactivate!
      PyramidScheme.configure_with_yml(
        File.join(File.dirname(__FILE__), '../configuration.example.yml'))
    end

    after(:each) do
      FakeFS.activate!
    end

    it 'should have a method that allows configuration from a yml file' do
        PyramidScheme.configuration[:secret_access_key].should_not be_nil
    end
    
    it 'should cast a string to a class if suffix of the configuraiton is class' do
      PyramidScheme.configuration[:index_provider_class].should eql(PyramidScheme::IndexProvider::S3)
    end
  end
end
