require 'spec_helper'

describe PyramidScheme::IndexClient do
  before(:each) do
    @client = PyramidScheme::IndexClient.new
  end

  it 'should have an index provider' do
    @client.index_provider.should_not be_nil
  end

  it 'should sleep if the index provider indicates the server is still indexing' do
    @client.index_provider.stubs(:index_in_progress?).returns(true).then.returns(false)
    Kernel.expects(:sleep).once
    @client.copy
    @client.copy_attempts.should eql(2)
  end

  it 'should raise an error if the server is stuck indexing' do
    Kernel.stub!(:sleep)
    @client.index_provider.stubs(:index_in_progress?).returns(true)
    lambda { @client.copy }.should raise_error
  end

  it 'should copy from the index provider and save files as new'
  it 'should send SIGHUP to active searchd processes'
end


