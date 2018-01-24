class StaticPagesController < ApplicationController
  def home
    @feed_posts = current_user.feed if logged_in?
  end
end
