namespace :cv do
  desc 'Import CV from xml'
  task :import, [:file_name]  => :environment do |t, args|
    CommonFunctions.import(args.file_name)
  end
end