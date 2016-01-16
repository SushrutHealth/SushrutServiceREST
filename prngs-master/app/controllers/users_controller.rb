class UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :deauth

  def deauth
    if params[:provider] == "facebook"
      @oauth = Facebook.oauth
      signed_request = @oauth.parse_signed_request(params[:signed_request])
      if signed_request
        user = User.find_by_uid(signed_request.data['user_id'])
        user.destroy
      end
    end
    render :nothing => true
  end
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @videos = Kaminari.paginate_array(@user.videos).page(params[:page]).per(10)
  end
end