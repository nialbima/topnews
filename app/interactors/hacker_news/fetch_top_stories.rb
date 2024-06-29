class HackerNews::FetchTopStories
  include Interactor

  def call
    context.fetched_top_story_ids = HackerNews::StoryFetcher.fetch_top_story_ids
  end
end
