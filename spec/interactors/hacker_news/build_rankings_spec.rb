require "rails_helper"

RSpec.describe HackerNews::BuildRankings, type: :interactor do
  describe ".call" do
    it "successfully assigns current_ranking and new_ranking" do
      current_ranking = [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]
      current_ranking.each { |(rank, id)| create :top_story, rank: rank, source_id: id }

      context = described_class.call(fetched_top_story_ids: [66, 254, 99, 188, 221, 132])
      expect(context).to be_a_success.and have_attributes(
        current_ranking: [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]],
        new_ranking: [[0, 66], [1, 254], [2, 99], [3, 188], [4, 221], [5, 132]]
      )
    end
  end
end
