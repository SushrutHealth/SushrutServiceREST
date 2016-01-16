class User < ActiveRecord::Base

  has_many :authentications, :dependent => :destroy
  has_and_belongs_to_many :videos

  def twitter_link
    "http://twitter.com/#{twitter_handle}"
  end

  def facebook_avatar
    "http://graph.facebook.com/#{facebook_uid}/picture"
  end

  def twitter_uid
    authentications.where{provider == "twitter"}.first.uid
  end

  def facebook_uid
    authentications.where{provider == "facebook"}.first.uid
  end
end