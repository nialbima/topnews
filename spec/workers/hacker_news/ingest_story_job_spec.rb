require "rails_helper"

RSpec.describe HackerNews::IngestStoryJob, type: :worker do
  describe ".perform" do
    it "ingests a single story" do
      rank = 1
      story_id = 254
      allow(HackerNews::IngestTopStory).to receive(:call).and_return(true)

      described_class.new.perform(rank, story_id)

      expect(HackerNews::IngestTopStory).to have_received(:call).with(story_id: story_id, rank: rank)
    end
  end
end
