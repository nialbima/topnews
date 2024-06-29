module HackerNews
  class TopStoryRankingBuilder
    attr_reader :story_ids, :current_ranking, :new_ranking
    def self.build(...)
      builder = new(...)
      builder.build
      builder
    end

    def initialize(story_ids:)
      @story_ids = story_ids
    end

    def build
      @current_ranking = fetch_current_ranking
      @new_ranking = build_new_ranking(story_ids)
    end

    private

    def build_new_ranking(top_story_ids)
      ## Build a multidimensional array of tuples containing rank and ID on HN.
      # Given an array of IDs [1,2,3]
      # We want to return an array of tuples [[0,1], [1,2], [2,3]].
      # This preserves the ranked order in the initial response.
      [(0...top_story_ids.length).to_a, top_story_ids].transpose
    end

    def fetch_current_ranking
      Rails.cache.read(HackerNews::TOP_STORIES_CACHE_KEY) ||
      Story.hacker_news.ranked_top_story_ids
    end
  end
end
