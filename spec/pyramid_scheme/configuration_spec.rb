require 'spec_helper'

describe PyramidScheme::Configuration do
  describe "from yml" do
    before(:each) do
      FakeFS.deactivate!
    end

    after(:each) do
      FakeFS.activate!
    end

    it 'should have a method that allows configuration from a yml file' do
      PyramidScheme.configure_with_yml(
        File.join(File.dirname(__FILE__), '../configuration.example.yml'))
        PyramidScheme.configuration[:secret_access_key].should_not be_nil
    end
  end
end
