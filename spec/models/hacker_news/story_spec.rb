require 'rails_helper'

RSpec.describe HackerNews::Story, type: :model do
  describe 'attributes' do
    it "initializes a story with cast attributes from a JSON payload" do
      VCR.use_cassette("hacker_news_story", record: :once) do
        id_in_cassette = 40820063
        payload = HackerNews::StoryFetcher.new.fetch_story_data(id_in_cassette)
        story = described_class.new(payload)

        expect(story).to have_attributes(
          id: 40820063,
          title: "New ways to catch gravitational waves",
          url: "https://www.nature.com/articles/d41586-024-02003-6",
          score: 73,
          by: "a_user_on_hackernews",
          time: Time.at(1719578482),
          type: "story",
          descendants: 29,
          kids: [40821387, 40820753, 40820741, 40821179, 40821401, 40821064, 40820567, 40820571]
        )
      end
    end
  end
end
