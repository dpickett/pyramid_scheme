require 'spec_helper' 

describe PyramidScheme::IndexClient do
  before(:each) do
    @client = PyramidScheme::IndexClient.new
  end

  it 'should have an index provider' do
    @client.index_provider.should_not be_nil
  end
 
  it 'should send SIGHUP to active searchd processes' do
    @client.expects(:searchd_pids).returns(["4345"])
    Process.expects(:kill).with("HUP", 4345)
    @client.bounce_pids
  end

  it 'should continue gracefully if no such process gets raise' do
    @client.expects(:searchd_pids).returns(["4345"])
    Process.expects(:kill).raises(Exception, "No Such Process").then.returns(1)
    lambda { @client.bounce_pids }.should_not raise_error
  end
end


