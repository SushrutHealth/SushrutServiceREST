class SessionsController < ApplicationController
  def new
  end

  def create
    auth = Authentication.from_omniauth(env["omniauth.auth"], current_user)
    user = auth.user
    session[:user_id] = user.id
    session[:provider] = auth.provider
    flash[:success] = "Connected with #{auth.provider.capitalize}"
    redirect_to root_url, params => nil
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end