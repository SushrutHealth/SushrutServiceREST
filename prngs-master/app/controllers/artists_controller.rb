class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    @videos = @artist.videos.page(params[:page]).per(10)
  end
end
