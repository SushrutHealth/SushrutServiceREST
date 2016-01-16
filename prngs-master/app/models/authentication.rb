class Authentication < ActiveRecord::Base

  belongs_to :user

  def self.from_omniauth(auth, current_user)
    if current_user.present?
      connect_with_omniauth(auth, current_user)
    else
      find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    user = User.new(:name => auth["info"]["name"])
    user.authentications.build(
      :provider => auth["provider"],
      :uid => auth["uid"]
    )
    assign_vendor_specific(auth, user)
    user.save!
    user.authentications.last
  end

  def self.connect_with_omniauth(auth, current_user)
    if previous_auth = find_by_provider_and_uid(auth["provider"], auth["uid"])
      migrate_user(auth, user)
    else
      current_user.authentications.build(
        :provider => auth["provider"],
        :uid => auth["uid"]
      )
    end
    assign_vendor_specific(auth, current_user)
    current_user.save!
    Authentication.where{user_id == current_user.id}.order{"updated_at DESC"}.limit(1).first
  end

  def self.migrate_user(auth, user)
    previous_user = auth.user
    previous_auth.user_id= user.id
    previous_auth.save!
    previous_user.destroy
  end

  def self.assign_vendor_specific(auth, user)
    if auth["provider"] == "twitter"
      user.twitter_handle = auth["info"]["nickname"]
      user.twitter_avatar = auth["extra"]["raw_info"]["profile_image_url"]
    elsif auth["provider"] == "facebook"
      user.email = auth["extra"]["raw_info"]["email"]
      user.facebook_link = auth["extra"]["raw_info"]["link"]
    end
  end
end