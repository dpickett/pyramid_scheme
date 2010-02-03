module PyramidScheme
  class IndexLockFile
    def self.path
      File.join(PyramidScheme.configuration[:source_path], 
        PyramidScheme.configuration[:lock_file_name])
    end

    def self.exists?
      File.exists?(path)
    end

    def self.create
      FileUtils.touch(path)
    end 

    def self.destroy
      FileUtils.rm_f(path)
    end
  end
end
