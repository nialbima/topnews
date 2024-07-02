class StoriesController < ApplicationController
  def index
    @top_stories = top_stories
  end

  def top_stories
    # We're set up for paginatino, and just need to implement the front-end UI based on design.
    Story.top_stories_with_rank.page(params[:page] || 1).per(params[:per] || 50)
  end
end
