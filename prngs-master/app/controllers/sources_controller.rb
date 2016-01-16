class SourcesController < ApplicationController
  
  def index
    @sources = Source.all
  end

  def show
    @source = Source.find(params[:id])
    @videos = Kaminari.paginate_array(@source.videos).page(params[:page]).per(10)
    @mentions = Mention.where{source == @source && text.length > 5 && video_id != nil}.from_last(1.year).random(3).uniq
  end
end