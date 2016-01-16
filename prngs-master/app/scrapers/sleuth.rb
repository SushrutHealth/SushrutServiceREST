# encoding: utf-8

module Sleuth

  module Feeds

    def self.discover
      Source.all.each do |source|
        source_feeds = filter(Feedbag.find(source.url))
        source.feeds = source_feeds
        source.save
        puts "#{source_feeds.size} Content Feeds Were Found for #{source.name}".green
      end
    end

    def self.filter(feeds)
      feeds.reject do |feed|
        feed.match(/comment|podcast|twitter/i) != nil
      end
    end
  end


  module HypeMachine

    def self.directory_url(page)
      "http://hypem.com/inc/serve_sites.php?ax=1&ts=#{Time.now.to_i}&alpha=all&page=#{page}"
    end

    def self.listing_url(fragment)
      "http://hypem.com#{fragment}?ax=1&ts=#{Time.now.to_i}"
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

    def self.construct_blogs_hash
      blogs_hash = {}
      active = true

      1000.times do |i|
        if active
          if i > 0 && i%10 == 0
            sleep 5.seconds
          end
          
          robot.get(directory_url(i)) do |page|
            if page.links.present?
              puts i.green
              page.links.each do |link|
                blogs_hash[link.text.strip!] = link.href
              end
            else
              active = false
            end
          end
          sleep 2.seconds
        else
          break
        end
      end

      blogs_hash
    end

    def self.discover_blogs
      blogs_hash = construct_blogs_hash
      blogs_hash.keys.reverse.each_with_index do |blog_name, i|
        begin
          robot.get(listing_url(blogs_hash[blog_name])) do |page|
            blog_url = page.at("h1 a:first-child")["href"]
            Source.construct(blog_name, blog_url, "Blog")
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
        ensure
          if i > 0 && i%20 == 0
            sleep 5.minutes
          else
            sleep (10 + rand(10)).seconds
          end
        end
      end
    end
  end
end
