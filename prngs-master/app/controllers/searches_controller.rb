class SearchesController < ApplicationController

  def search
    @query = params[:video_or_sources_or_artists_name]
    videos = Video.primary_search(@query)
    artists = Artist.primary_search(@query)
    sources = Source.primary_search(@query)
    @results = { :videos => videos.results,
                 :artists => artists.results,
                 :sources => sources.results
               }
  end
end
