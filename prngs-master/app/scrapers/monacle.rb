# encoding: utf-8

module Monacle

  module Feeds

    def self.squint(entry)
      reduce entry
    end

    def self.reduce(entry)
      sample(entry).match(/\b(vid\w*)|\b(watch\w*)|mp4/i).present? ? entry : nil
    end

    def self.sample(entry)
      entry.andand.title
    end

    def self.keywords(entry)
      entry.andand.categories.andand.join(" ")
    end
  end


  module Mentions

    def self.squint(mention, page)
      puts "#{mention.source.andand.name}".green
      reduce(mention, page)
    end

    def self.reduce(mention, page)
      elect(mention, nominate(page))
    end

    def self.nominate(page)
      candidates = []
      page.links.andand.each do |link|
        candidates.push link.href
      end
      page.iframes.andand.each do |iframe|
        candidates.push iframe.attributes["src"]
      end
      candidates.delete_if do |url|
        url.nil? || url.match(/youtu|vimeo/).nil?
      end
    end

    def self.elect(mention, candidates)
      candidates_hash = {}
      candidates.each do |candidate|
        candidates_hash[candidate] = sample(candidate) || ""
      end
      score(mention.title, candidates_hash)
    end

    def self.score(scorer, candidates)
      candidates.each do |candidate|
        candidates[candidate.first] = scorer.pair_distance_similar candidate.last
      end
      frontrunner = candidates.values.sort.reverse.first
      candidates.key(frontrunner)
    end

    def self.sample(candidate)
      begin
        VideoInfo.new(candidate, "User-Agent" => user_agent).title
      rescue StandardError => ex
        puts "#{ex.message}".red
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end
  end


  module Videos

    def self.squint(videos)
      [videos].flatten.in_groups_of(2, false) do |video_group|
        video_group.flatten.map do |video|
          begin
            reduce video
          rescue StandardError => ex
            puts "#{ex.inspect}".red
          end
        end
        sleep 1.seconds
      end
    end

    def self.reduce(video)
      unless video.andand.artists.present? || video.title.nil?
        text_sample = sample(video.title)
        puts "\n#{text_sample.green}\n\n"
        video.artist_ids= Echonest.extract(text_sample).flatten.andand.map(&:id)
        video.save
      end
    end

    def self.sample(title)
      # Match #1
      # Artist Name - Track Name
      # Artist Name – Track Name
      # Artist Name ~ Track Name
      # Artist Name "Track Name"
      # Artist Name 'Track Name'

      # Match #2
      # "Track Name" - Artist Name
      # "Track Name" — Artist Name
      # "Track Name" ~ Artist Name
      # 'Track Name' - Artist Name
      # 'Track Name' — Artist Name
      # 'Track Name' ~ Artist Name

      # Match #3
      # Track Name by Artist Name
      # "Track Name" by Artist Name
      # 'Track Name' by Artist Name

      if title.match(/(\A[^"'].*) (["']|[-–—~]{1} .*)/).present? ||
         title.match(/\A["']{1}.*["']{1}\s?[-–—~]?\s?(.*)/).present? ||
         title.match(/\A.* by (.*)/).present?

        title = $1
      end
      scrub title
    end

    def self.scrub(text)
      if text.match(/ [-–—~]( |\z)/).present? ||
         text.match(/\A.* by (.*)/i).present? ||
         text.match(/ - |ft.|feat | feat\.|featuring|exclusive|premier./i).present? ||
         text.match(/(\(|\[)Official.*(\]|\))/i).present?

         text = text.gsub(/ [-–—~]( |\z)/, " ").gsub(/\A.* by (.*)/i, " ").gsub(/ - |ft.|feat |\.feat|featuring|exclusive|premier./i, " ").gsub(/(\(|\[)Official.*(\]|\))/i, " ").strip!
      end
      text
    end
  end


  module Artists

    def self.squint(artist)
      begin
        images = LastFM::Artist.get_images(:artist => artist.name)["images"]["image"]
        square_images = []
        images.each do |image|
          squares = image["sizes"]["size"].reject do |size|
            size["name"] != "largesquare"
          end
          square_images.push squares
        end
        artist.images = square_images.flatten
        artist.save
        puts artist.images
      rescue
      end
      sleep 1.second
    end
  end
end
