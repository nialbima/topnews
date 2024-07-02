require "rails_helper"

RSpec.describe Story, type: :model do
  describe "validations" do
    it "should validate presence of title, url, source, and source_id" do
      story = create :story
      [:title, :url, :source, :source_id].each do |attr|
        expect(story).to validate_presence_of(attr)
      end
    end

    it "should validate uniqueness of source_id scoped to source" do
      story = create :story
      expect(story).to validate_uniqueness_of(:source_id).scoped_to(:source)
    end
  end

  describe "associations" do
    it "has many flagging users through flags" do
      story = create :story
      user = create :valid_user
      _flag = create :flag, story: story, user: user

      expect(story.flagging_users).to include(user)
    end
  end

  describe "enums" do
    it "uses a DB-level enum for source" do
      story = build_stubbed :story
      expect(story).to define_enum_for(:source).backed_by_column_of_type(:enum).with_values(
        hacker_news: "hacker_news"
      )
    end
  end

  describe "class methods" do
    describe ".from_hacker_news" do
      it "initializes a new story from a HackerNews::TopStory object" do
        top_story = HackerNews::TopStory.new(
          id: 123,
          title: "Wow V. Cool",
          url: "www.wow.cool",
          type: "story",
          score: 100,
          by: "a_user_on_hackernews",
          time: Time.now.to_i,
          descendants: 10,
          kids: [1, 2, 3]
        )

        story = described_class.from_hacker_news(top_story_object: top_story, is_top_story: true)
        expect(story).to be_a(Story).and be_new_record.and be_valid.and have_attributes(
          title: "Wow V. Cool",
          url: "www.wow.cool",
          source_id: 123,
          is_top_story: true
        )
      end
    end
  end
end
