namespace :weekly do

  desc "Set timestamp"
  task :begin, [:scope] => :environment do |t,args|
    puts "\nSTART: #{Time.now}\n\n"
    Rails.application.eager_load!
  end

  desc "Discover source popularity on social networks"
  task :discover_source_popularity, [:scope] => :begin do |t,args|
    puts "\nBeanCounter.rank(Source.all)\n\n"
    BeanCounter.rank(Source.all)
  end

  desc "Discover artist popularity from EchoNest"
  task :discover_artist_popularity, [:scope] => :discover_source_popularity do |t,args|
    puts "\nLasso::Artists.wrangle(Artist.all)\n\n"
    Lasso::Artists.wrangle(Artist.all)
  end

  desc "Set timestamp"
  task :init, [:scope] => :discover_artist_popularity do |t,args|
    puts "\nEND: #{Time.now}\n\n"
    Process::abort
  end
end