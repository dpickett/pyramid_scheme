module PyramidScheme
  class ProcessManager
    def self.searchd_pids
      Rush.processes.filter(:cmdline => /searchd/)
    end

    def self.bounce_searchd
      searchd_pids.each do |process|
        begin
          Process.kill("HUP", process.pid) 
        rescue Exception => e
          raise e unless e.message =~ /No such process/i
        end
      end
    end

  end
end
