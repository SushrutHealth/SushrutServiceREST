module SearchesHelper

  def search_counts(query, results)
    video_count = results[:videos].count
    artist_count = results[:artists].count
    source_count = results[:sources].count

    search_counts_html = <<-eos
      <div class="counts">
        <span class="found">Found </span>
        <div class="count">
          <strong>#{video_count}</strong>
          <span>#{pluralize_without_count(video_count, "Video")}, </span>
        </div>
        <div class="count">
          <strong>#{artist_count}</strong>
          <span>#{pluralize_without_count(artist_count, "Artist")}, </span>
        </div>
        <div class="count">
          <span>and </span>
          <strong>#{source_count}</strong>
          <span>#{pluralize_without_count(source_count, "Source")}</span>
        </div>
        <span class="for-artist"> for <strong>#{query}</strong></span>
      </div>
    eos
    search_counts_html.html_safe
  end
end
