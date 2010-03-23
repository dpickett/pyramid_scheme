module PyramidScheme
  # PyramidScheme::Tasks.new('path/to/configuration/yml')
  class Tasks < ::Rake::TaskLib
    attr_reader :yml_path

    def initialize(yml_path = nil)
      unless yml_path.nil?
        @yml_path = yml_path 
        configure_with_yml
      end
      define
    end

    protected
    def configure_with_yml
      PyramidScheme.configure_with_yml(@yml_path)
    end

    def define
      namespace :pyramid_scheme do
        desc "retrieve new sphinx indexes as the client"
        task :retrieve do
          PyramidScheme::IndexClient.new.retrieve_index
        end

        desc "create new sphinx indexes as the server"
        task :index do
          PyramidScheme::IndexServer.new.index
        end
      end
    end
    
  end
end
