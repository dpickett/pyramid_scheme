module PyramidScheme
  class ProcessManager
    def self.searchd_pids
      Rush.processes.filter(:cmdline => /searchd/)
    end

    def self.bounce_searchd
      kill_searchd_with_signal("HUP")
    end
    
    def self.kill_searchd
      kill_searchd_with_signal("KILL")
    end
    
    protected
    def self.kill_searchd_with_signal(signal)
      searchd_pids.each do |process|
        begin
          Process.kill(signal, process.pid) 
        rescue Exception => e
          raise e unless e.message =~ /No such process/i
        end
      end
    end
  end
end
