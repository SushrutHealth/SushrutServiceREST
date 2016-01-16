module VideosHelper

  def duration(video)
    time = Time.at(video.duration).gmtime.strftime('%M:%S').to_s
    if time.length > 5
      time = time.gsub!(/\A00:/, "")
    end
    time
  end

  def youtube_player(video)
    if video.provider.downcase == "youtube"
      "<iframe width='640' height='385' src='http://www.youtube.com/embed/#{video.video_id}?wmode=transparent' frameborder='0' allowfullscreen></iframe>".html_safe
    elsif video.provider.downcase == "vimeo"
      "<iframe src='http://player.vimeo.com/video/#{video.video_id}?title=0&amp;byline=0&amp;portrait=0&amp;color=0fb0d4&amp;wmode=transparent' width='560' height='315' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>".html_safe
    else
      video.title
    end
  end

  def source_links(video)
    sources_html = ""
    video.sources.uniq.first(3).each do |source|
      sources_html += "<a href='#{source_path(source)}' class='source'><span class='label'>#{source.name}</span></a>"
    end
    sources_html.html_safe
  end
end
