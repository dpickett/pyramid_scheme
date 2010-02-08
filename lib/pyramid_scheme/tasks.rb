namespace :pyramid_scheme do
  task :retrieve => :environment do
    PyramidScheme::IndexClient.new.retrieve_index
  end

  task :index => :environment do
    PyramidScheme::IndexServer.new.index
  end
end
