namespace :monthly do

  desc "Set timestamp"
  task :timestamp, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
    Rails.application.eager_load!
  end

  desc "Discover sources from the Hype Machine"
  task :discover_sources, [:scope] => :timestamp do |t,args|
    Sleuth::HypeMachine.discover_blogs
  end

  desc "Set timestamp"
  task :init, [:scope] => :discover_video_mentions do |t,args|
    Rails.logger.debug("END: #{Time.now}")
    Process::abort
  end
end