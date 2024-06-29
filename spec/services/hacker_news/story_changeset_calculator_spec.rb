require "rails_helper"

RSpec.describe HackerNews::StoryChangesetCalculator do
  let(:current_ranking) { [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]] }
  let(:new_ranking) { [[0, 66], [1, 254], [2, 99], [3, 188], [4, 221], [5, 132]] }

  describe ".calculate_changesets" do
    it "returns the set of stories that are still top stories at the same rank" do
      calculator = described_class.calculate_changesets(current_ranking: current_ranking, new_ranking: new_ranking)

      static_story = [[2, 99]]
      expect(calculator.static_top_set).to eq(static_story)
    end

    it "returns the set of new top stories not present in current stories" do
      calculator = described_class.calculate_changesets(current_ranking: current_ranking, new_ranking: new_ranking)

      new_id_with_rank = [[1, 254], [4, 221]]
      expect(calculator.new_top_set).to eq(new_id_with_rank)
    end

    it "returns the set of existing top stories found in current stories at their updated rank" do
      calculator = described_class.calculate_changesets(current_ranking: current_ranking, new_ranking: new_ranking)

      found_ids_with_new_ranks = [[0, 66], [3, 188], [5, 132]]
      expect(calculator.moved_top_set).to eq(found_ids_with_new_ranks)
    end

    it "returns the set of existing top stories no longer present in new top stories" do
      calculator = described_class.calculate_changesets(current_ranking: current_ranking, new_ranking: new_ranking)

      missing_id_with_rank = [[0, 33], [4, 155]]
      expect(calculator.not_top_set).to eq(missing_id_with_rank)
    end
  end
end
