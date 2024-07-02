require "rails_helper"

RSpec.describe HackerNews::TopStoryRankingBuilder do
  before do
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  describe "#build" do
    it "stores new and current rankings as arrays of tuples containing rank and ID" do
      create :top_story, rank: 0, source_id: 4
      create :top_story, rank: 1, source_id: 5
      create :top_story, rank: 2, source_id: 6

      top_story_ids = [1, 2, 3]

      expected_new_ranking = [[0, 1], [1, 2], [2, 3]]
      expected_current_ranking = [[0, 4], [1, 5], [2, 6]]

      builder = described_class.build(story_ids: top_story_ids)

      expect(builder.new_ranking).to eq(expected_new_ranking)
      expect(builder.current_ranking).to eq(expected_current_ranking)
    end

    it "returns the cached ranking of top stories when present" do
      current_ranking = [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]

      HackerNews::UpdateCache.call(new_ranking: current_ranking)

      allow(Story).to receive(:ranked_top_story_ids).and_call_original

      builder = described_class.build(story_ids: [])

      expect(Story).not_to have_received(:ranked_top_story_ids)
      expect(builder.current_ranking).to eq(current_ranking)
    end

    it "queries the DB for relevant top stories when there's nothing in the cache" do
      current_ranking = [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]
      current_ranking.each do |(rank, id)|
        create :top_story, rank: rank, source_id: id
      end

      allow(Story).to receive(:ranked_top_story_ids).and_call_original

      builder = nil
      expect {
        builder = described_class.build(story_ids: [])
      }.not_to change { Rails.cache.read(HackerNews::TOP_STORIES_CACHE_KEY) }

      expect(Rails.cache.read(HackerNews::TOP_STORIES_CACHE_KEY)).to be_blank
      expect(Story).to have_received(:ranked_top_story_ids)
      expect(builder.current_ranking).to eq(current_ranking)
    end
  end
end
