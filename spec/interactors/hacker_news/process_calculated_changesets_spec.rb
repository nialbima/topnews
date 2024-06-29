require 'rails_helper'

RSpec.describe HackerNews::ProcessCalculatedChangesets, type: :interactor do
  describe '.call' do
    it "schedules processes all indicated stories" do
      new_top_set = [[1, 254], [4, 221]]
      moved_top_set = [[2, 30], [5, 512]]
      not_top_set = [[9, 300], [7, 2]]

      allow(HackerNews::IngestStoryJob).to receive(:perform_bulk).and_return(true)
      allow(HackerNews::UpdateStoryJob).to receive(:perform_bulk).and_return(true)
      allow(HackerNews::DemoteStoriesJob).to receive(:perform_async).and_return(true)

      context = described_class.call(new_top_set: new_top_set, moved_top_set: moved_top_set, not_top_set: not_top_set)

      expect(context).to be_a_success

      expect(HackerNews::IngestStoryJob).to have_received(:perform_bulk).with(new_top_set)
      expect(HackerNews::UpdateStoryJob).to have_received(:perform_bulk).with(moved_top_set)
      expect(HackerNews::DemoteStoriesJob).to have_received(:perform_async).with(not_top_set)
    end

    it "doesn't do anything if no stories are indicated" do

      allow(HackerNews::IngestStoryJob).to receive(:perform_bulk).and_return(true)
      allow(HackerNews::UpdateStoryJob).to receive(:perform_bulk).and_return(true)
      allow(HackerNews::DemoteStoriesJob).to receive(:perform_async).and_return(true)

      context = described_class.call(new_top_set: [], moved_top_set: [], not_top_set: [])

      expect(context).to be_a_success

      expect(HackerNews::IngestStoryJob).not_to have_received(:perform_bulk)
      expect(HackerNews::UpdateStoryJob).not_to have_received(:perform_bulk)
      expect(HackerNews::DemoteStoriesJob).not_to have_received(:perform_async)
    end
  end
end
