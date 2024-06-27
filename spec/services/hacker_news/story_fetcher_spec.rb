require "rails_helper"

RSpec.describe HackerNews::StoryFetcher do
  describe ".fetch_top_story_ids" do
    it "returns the top stories" do
      VCR.use_cassette("hacker_news_top_stories", record: :once) do
        stories = described_class.fetch_top_story_ids
        expect(stories).to be_an(Array).and all(be_an(Integer)).and have_attributes(size: 500)
      end
    end
  end

  describe ".fetch_story_data" do
    it "returns a story" do
      story_id = 40820063

      VCR.use_cassette("hacker_news_story", record: :once) do
        story = described_class.fetch_story_data(story_id)

        ## I edited the VCR cassette by hand to avoid including somebody's username in my commit.
        expect(story).to include(
          { "by"=>"a_user_on_hackernews",
            "descendants"=>29,
            "id"=>40820063,
            "kids"=>[40821387, 40820753, 40820741, 40821179, 40821401, 40821064, 40820567, 40820571],
            "score"=>73,
            "time"=>1719578482,
            "title"=>"New ways to catch gravitational waves",
            "type"=>"story",
            "url"=>"https://www.nature.com/articles/d41586-024-02003-6"
          }
        )
      end
    end
  end
end
