# encoding: utf-8

module UsersHelper

  def connection_status(provider, current_user)
    if current_user.authentications.map(&:provider).include? provider
      "#{provider.capitalize}<span>✔</span>".html_safe
    else
      "<a href='/auth/#{provider}'>#{provider.capitalize}</a><span>✘</span>".html_safe
    end
  end

  def user_avatar(current_user)
    image_url = current_user.facebook_avatar || current_user.twitter_avatar
    link_to image_tag(image_url, :alt => current_user.name), user_path(current_user)
  end
end