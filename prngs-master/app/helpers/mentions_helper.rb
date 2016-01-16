module MentionsHelper

  def clean_content(html)
    if sanitized = Sanitize.clean(html)
      truncate(sanitized, :length => 183)
    else
      ""
    end.html_safe
  end
end
