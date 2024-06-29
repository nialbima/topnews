require "rails_helper"

RSpec.describe HackerNews::IngestTopStory do
  describe ".call" do
    it "ingests a story" do
      VCR.use_cassette("hacker_news_story") do
        story_id = 40820063
        rank = 0

        expect { described_class.call(story_id: story_id, rank: rank) }.to change(Story, :count).by(1)

        output = Story.hacker_news.last
        expect(output.source_id).to eq(story_id)
        expect(output.is_top_story).to eq(true)
      end
    end
  end
end
