class HackerNews::UpdateCache
  include Interactor

  delegate :new_ranking, to: :context

  def call
    Rails.cache.write(HackerNews::TOP_STORIES_CACHE_KEY, new_ranking, expires_in: 5.minutes)
  end
end
