require 'spec_helper' 

describe PyramidScheme::IndexClient do
  before(:each) do
    @client = PyramidScheme::IndexClient.new
  end

  it 'should have an index provider' do
    @client.index_provider.should_not be_nil
  end
 
  it 'should send SIGHUP to active searchd processes' do
    stub_rush_process_list
    Process.expects(:kill).with("HUP", @pid)
    @client.bounce_pids
  end

  it 'should continue gracefully if no such process gets raise' do
    stub_rush_process_list
    Process.expects(:kill).raises(Exception, "No Such Process").then.returns(1)
    lambda { @client.bounce_pids }.should_not raise_error
  end

  def stub_rush_process_list
    processes = [mock]
    @pid = 4345
    processes[0].expects(:pid).returns(@pid)
    Rush.processes.expects(:filter).with(:cmdline => /searchd/).returns(processes)
  end
end


