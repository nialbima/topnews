require "rails_helper"

RSpec.describe HackerNews::CalculateChanges, type: :interactor do
  before do
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  describe ".call" do
    it "successfully assigns calculated_changesets from an ordered list of IDs" do
      current_ranking = [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]
      current_ranking.each { |(rank, id)| create :top_story, rank: rank, source_id: id }


      builder = HackerNews::TopStoryRankingBuilder.build(story_ids: [66, 254, 99, 188, 221, 132])
      context = described_class.call(
        current_ranking: builder.current_ranking,
        new_ranking: builder.new_ranking
      )

      expect(context).to have_attributes(
          current_ranking: [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]],
          new_ranking: [[0, 66], [1, 254], [2, 99], [3, 188], [4, 221], [5, 132]],
          new_top_set: [[1, 254], [4, 221]],
          moved_top_set: [[0, 66], [3, 188], [5, 132]],
          not_top_set: [[0, 33], [4, 155]],
          static_top_set: [[2, 99]]
        )
    end
  end
end
