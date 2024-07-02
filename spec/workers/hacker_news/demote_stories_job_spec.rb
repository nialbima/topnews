require "rails_helper"

RSpec.describe HackerNews::DemoteStoriesJob, type: :worker do
  describe ".perform" do
    it "demotes all indicated stories" do
      create :top_story, :hacker_news, source_id: 1
      create :top_story, :hacker_news, source_id: 2

      described_class.new.perform(ids: [[0, 1], [1, 2]])

      results = Story.hacker_news.where(source_id: [1, 2]).map(&:is_top_story?)
      expect(results).to all(eq(false))
    end
  end
end
