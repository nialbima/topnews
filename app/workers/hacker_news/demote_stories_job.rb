module HackerNews
  class DemoteStoriesJob
    include Sidekiq::Job

    def perform(ids)
      Story.hacker_news.where(source_id: ids.map(&:last)).update(is_top_story: false)
    end
  end
end
