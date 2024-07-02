require "rails_helper"

RSpec.describe HackerNews::FetchTopStories, type: :interactor do
  describe ".call" do
    it "successfully assigns fetched_top_story_ids from the API response" do
      init_double = instance_double(HackerNews::StoryFetcher)
      allow(HackerNews::StoryFetcher).to receive(:new).and_return(init_double)
      allow(init_double).to receive(:fetch_top_story_ids).and_return([2, 1, 3])

      context = described_class.call
      expect(context.fetched_top_story_ids).to eq([2, 1, 3])
      expect(init_double).to have_received(:fetch_top_story_ids)
    end
  end
end
