module Facebook

  def self.oauth
    Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET)
  end
end