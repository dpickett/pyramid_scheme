require 'spec_helper' 

describe PyramidScheme::IndexClient do
  before(:each) do
    @client = PyramidScheme::IndexClient.new
  end

  it 'should have an index provider' do
    @client.index_provider.should_not be_nil
  end

  it 'should bounce pids after indexing' do
    @client.index_provider.stubs(:retrieve_index)

    PyramidScheme::ProcessManager.expects(:bounce_searchd)
    @client.retrieve_index
  end
 
end


