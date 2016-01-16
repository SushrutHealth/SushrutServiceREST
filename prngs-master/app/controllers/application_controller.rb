class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :suggested
  before_filter :mentions
  before_filter :body_class

  after_filter :set_pjax_headers

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def body_class
    @body_class ||= "#{params[:controller]} #{params[:action]}" || ""
  end

  def set_pjax_headers
    response.headers['X-PJAX-CONTEXT'] = body_class
  end

  def suggested
    @suggested = OpenStruct.new({
      :sources => Source.select([:id, :name, :popularity]).includes([:mentions]).most_relevant.first(5),
      :artists => Artist.select([:id, :name, :popularity]).includes([:videos]).top(5),
      :users => User.select([:id, :name]).includes([:videos]).first(5)
    })
  end

  def mentions
    @mentions = Mention.from_last(36.hours).where{text.length > 5 && video_id != nil}.includes([:video]).random(3).uniq
  end
end
