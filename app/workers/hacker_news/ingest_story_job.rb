module HackerNews
  class IngestStoryJob
    include Sidekiq::Job

    def perform(rank, story_id)
      # If this app had access to Sidekiq Batches, we'd structure this such that batch completion would broadcast
      # a Turbo stream to update the UI with the new top stories. Since we don't have that, they can just reload.
      HackerNews::IngestTopStory.call(story_id: story_id, rank: rank)
    end
  end
end
