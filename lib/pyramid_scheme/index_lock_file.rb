module PyramidScheme
  class IndexLockFile
    def self.server_path
      File.join(PyramidScheme.configuration[:server_destination_path], 
        PyramidScheme.configuration[:lock_file_name])
    end

    def self.client_path
      File.join(PyramidScheme.configuration[:client_source_path], 
        PyramidScheme.configuration[:lock_file_name])
    end

    def self.exists?
      File.exists?(client_path)
    end

    def self.create
      FileUtils.touch(server_path)
    end 

    def self.destroy
      FileUtils.rm_f(server_path)
    end
  end
end
