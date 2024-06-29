module HackerNews
  class UpdateStoryJob
    include Sidekiq::Job
    def perform(rank, story_id)
      Story.find_by(source_id: story_id).update!(rank: rank)
      # Broadcast here
    end
  end
end
