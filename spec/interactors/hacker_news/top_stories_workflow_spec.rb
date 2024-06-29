require 'rails_helper'

RSpec.describe HackerNews::TopStoriesWorkflow, type: :interactor do
  describe '.organized' do
    it "organizes the interactors in the correct order" do
      expect(described_class.organized).to eq(
        [
          HackerNews::FetchTopStories,
          HackerNews::BuildRankings,
          HackerNews::CalculateChanges,
          HackerNews::ProcessCalculatedChangesets,
          HackerNews::UpdateCache
        ]
      )
    end
  end
end
