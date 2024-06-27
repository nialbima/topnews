module HackerNews
  class TopStory
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :score, :integer
    attribute :descendants, :integer
    attribute :title, :string
    attribute :url, :string
    attribute :type, :string
    attribute :by, :string
    # We get time from the API as UNIX epoch time, so we need to cast it to a Ruby Time object.
    attribute :time, :epoch_time
    # You can't use array: true without access to the Postgres db. A simple cast solves it.
    attribute :kids, :array_of_integers

    def to_story_record
      Story.from_hacker_news(top_story_object: self, is_top_story: true)
    end
  end
end
