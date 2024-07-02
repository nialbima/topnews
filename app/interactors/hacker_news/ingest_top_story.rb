module HackerNews
  class IngestTopStory
    include Interactor

    def call
      story_data = StoryFetcher.fetch_story_data(context.story_id)
      mapped_object = TopStory.new(story_data)

      mapped_object.rank = context.rank
      story_record = mapped_object.to_story_record

      # something like this! https://discuss.hotwired.dev/t/how-to-broadcast-from-a-background-job/4125/9
      story_record.save!
    end
  end
end
