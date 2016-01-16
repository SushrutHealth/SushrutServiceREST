# encoding: utf-8

module Lasso

  module Feeds

    def self.wrangle
      Source.where{kind != "Twitter"}.each do |source|
        begin
          puts "#{source.name}".green
          source.feeds.each do |feed|
            Feedzirra::Feed.fetch_and_parse(feed, :timeout => 20,
                                                          :if_modified_since => Time.now - 24.hours,
                                                          :on_success => lambda {|url, feed| dispatch(source, feed.entries) }
            )
          end
        rescue StandardError => e
          puts "#{e}".red
        end
      end
    end

    def self.dispatch(source, entries)
      entries.andand.each do |entry|
        begin
          entry = Monacle::Feeds.squint(entry)
          unless entry.nil? || entry.andand.title.blank? || entry.andand.url.blank?
            puts "#{entry.title.gsub(/\n?/, '')}".green
            Mention.construct(source, entry)
          end
        rescue StandardError => e
          puts "#{e}".red
        end
      end
    end
  end


  module Tweets

    YAML_FILE = YAML::load(File.open("#{Rails.root}/config/twitter_lists.yml"))

    def self.lists
      YAML_FILE
    end

    def self.write_yaml
      File.open("#{Rails.root}/config/twitter_lists.yml", 'w') do |file|
        file.write(lists.to_yaml)
      end
    end

    def self.wrangle
      i = 0
      timelines = []
      cached_lists = lists
      lists_count = cached_lists.count
      cached_lists.each do |listname, values|
        i += 1
        list_timeline(values["user"], listname.to_s, values["since_id"]) rescue nil
      end

      if i == lists_count
        puts "Success".green
        write_yaml
      end
    end

    def self.harvest(*args)
      options = args.extract_options!
      status = options[:status]
      video = options[:video]
      url = options[:url]

      screen_name = status.attrs["user"]["screen_name"].downcase
      puts status.text.green rescue nil

      source = Source.construct(screen_name, "http://twitter.com/#!/#{screen_name}", "Twitter")

      entry = OpenStruct.new(
        :title => status.text,
        :content => status.text,
        :url => url,
        :published => status.created_at.to_s.split(" -")[0]
      )

      mention = Mention.construct(source, entry)

      if video.andand.valid?
        video.url = scrub(video.url)
        puts "#{video.title}".green
        Video.construct(mention, video)
      end
    end

    def self.list_timeline(username, listname, since_id)
      list = Twitter.list_timeline(username, listname, :include_entities => true, :per_page => 500, :since_id => since_id)

      list.each do |status|
        if status == list.last
          lists[listname]["since_id"] = status.id
        end

        if status.text.match(/\b(vid\w*)|\b(watch\w*)|mp4/i)
          filter(status)
        end
      end
    end

    def self.filter(status)
      expanded_url = status.attrs["entities"]["urls"].pop["expanded_url"] rescue ""
      video = VideoInfo.new(expanded_url, "User-Agent" => user_agent) rescue nil

      if status && expanded_url.length > 0
        harvest(:status => status, :video => video, :url => expanded_url)
      end
    end

    def self.scrub(url)
      if url.match(/vimeo/).present?
        url.gsub(/player.|video\//, "")
      else
        url
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end
  end


  module Mentions

    def self.wrangle(mentions)
      mentions.each do |mention|
        begin
          robot.get(mention.url) do |page|
            dispatch(mention, page)
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
        end
      end
    end

    def self.dispatch(mention, page)
      video_url = Monacle::Mentions.squint(mention, page)
      unless video_url.blank?
        begin
          video_url = scrub(video_url)
          video = VideoInfo.new(video_url, "User-Agent" => user_agent)
        rescue StandardError => ex
          puts "#{ex.message}".red
        end
        if video.valid?
          video.url = video_url
          Video.construct(mention, video)
        else
          puts "#{video_url}".red
        end
      end
    end

    def self.scrub(url)
      if url.match(/vimeo/).present?
        url.gsub(/player.|video\//, "")
      else
        url
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end

    def self.user_agents
      ['Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla']
    end

    def self.robot
      Mechanize.new do |agent|
        agent.user_agent_alias = user_agents[rand(user_agents.size)]
        agent.follow_meta_refresh = true
      end
    end
  end


  module Artists

    def self.wrangle(artists)
      [artists].flatten.in_groups_of(2, false).each do |artist_group|
        artist_group.flatten.each do |artist|
          begin
            Echonest.profile(artist)
            Monacle::Artists.squint(artist)
            puts "#{artist.name}".green
          rescue StandardError => ex
            puts "#{ex.message}".red
          end
        end
        sleep 1.seconds
      end
    end
  end
end
