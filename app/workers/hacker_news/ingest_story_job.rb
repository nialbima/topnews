module HackerNews
  class IngestStoryJob
    include Sidekiq::Job

    def perform(rank, story_id)
      HackerNews::IngestTopStory.call(story_id: story_id, rank: rank)
    end
  end
end
