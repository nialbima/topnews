class FlaggedStoriesController < ApplicationController

  def index
    @flagged_stories = flagged_stories
  end

  def flagged_stories
    Story.flagged_stories.page(params[:page] || 1).per(params[:per] || 25)
  end

end
