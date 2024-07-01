class StoriesController < ApplicationController

  def index
    @top_stories = top_stories
  end

  def top_stories
    Story.top_stories_with_rank.page(params[:page] || 1).per(params[:per] || 25)
  end

end
