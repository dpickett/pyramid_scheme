namespace :pyramid_scheme do
  desc "retrieve new sphinx indexes as the client"
  task :retrieve => :environment do
    PyramidScheme::IndexClient.new.retrieve_index
  end

  desc "create new sphinx indexes as the server"
  task :index => :environment do
    PyramidScheme::IndexServer.new.index
  end
end
