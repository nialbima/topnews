module HackerNews
  class StoryFetcher

    def self.fetch_top_story_ids
      new.fetch_top_story_ids
    end

    def self.fetch_story_data(story_id)
      new.fetch_story_data(story_id)
    end

    def fetch_story_data(story_id)
      api_client.get("item/#{story_id}").body
    end

    def fetch_top_story_ids
      api_client.get("topstories").body
    end

    private

    def api_client
      Firebase::Client.new(base_uri)
    end

    def base_uri
      "#{hacker_news_config.fetch(:firebase_url)}/#{hacker_news_config.fetch(:api_version)}"
    end

    def hacker_news_config
      Rails.application.secrets.hacker_news
    end
  end
end
