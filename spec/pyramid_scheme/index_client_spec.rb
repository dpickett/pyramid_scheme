require 'spec_helper' 

describe PyramidScheme::IndexClient do
  before(:each) do
    @client = PyramidScheme::IndexClient.new
  end

  it 'should have an index provider' do
    @client.index_provider.should_not be_nil
  end
 
  it 'should send SIGHUP to active searchd processes'
end


