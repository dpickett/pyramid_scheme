require 'spec_helper'

describe PyramidScheme::ProcessManager do
  it 'should send SIGHUP to active searchd processes' do
    stub_rush_process_list
    Process.expects(:kill).with("HUP", @pid)
    PyramidScheme::ProcessManager.bounce_searchd
  end

  it 'should continue gracefully if no such process gets raise' do
    stub_rush_process_list
    Process.expects(:kill).raises(Exception, "No Such Process").then.returns(1)
    lambda { PyramidScheme::ProcessManager.bounce_searchd }.should_not raise_error
  end

  def stub_rush_process_list
    processes = [mock]
    @pid = 4345
    processes[0].expects(:pid).returns(@pid)
    Rush.stubs(:processes).returns(mock)
    Rush.processes.expects(:filter).with(:cmdline => /searchd/).returns(processes)
  end

end
