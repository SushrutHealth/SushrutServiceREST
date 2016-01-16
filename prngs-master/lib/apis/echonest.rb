require 'net/http'
require 'json'

module Echonest

  API_KEY = 'DAAUDTGOP2UZ3GZSS'

  def self.make_request(url)
    response = Net::HTTP.get(URI(url))
    response = JSON.parse(response)
    OpenStruct.new(response["response"])
  end

  def self.extract(text)
    url = "http://developer.echonest.com/api/v4/artist/extract?api_key=#{API_KEY}&format=json&text=#{URI.encode(text)}&results=3"
    response = make_request(url)
    if response.status["message"] == "Success"
      response.artists.map do |artist|
        Artist.construct(OpenStruct.new(artist))
      end
    end
  end

  def self.profile(artist)
    url = "http://developer.echonest.com/api/v4/artist/profile?api_key=#{API_KEY}&id=#{artist.echonest_id}&format=json&bucket=biographies&bucket=familiarity&bucket=hotttnesss&bucket=images"
    response = make_request(url)
    if response.status["message"] == "Success"
      response = OpenStruct.new(response.artist)
      artist.update_attributes(
        :popularity => response.hotttnesss,
        :familiarity => response.familiarity,
        :biographies => response.biographies
      )
    end
  end
end
