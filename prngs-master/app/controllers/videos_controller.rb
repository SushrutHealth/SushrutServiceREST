class VideosController < ApplicationController

  autocomplete :video_and_sources_and_artists_search,
               { :video => [:title],
                 :source => [:name],
                 :artist => [:name]
               },
               :limit => 5

  def index
    @videos = Video.top(50).from_last(2.weeks)
  end

  def show
    @video = Video.find(params[:id])
  end
end
