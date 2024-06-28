class Story < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :flagging_users, through: :flags, source: :user

  ## NOTE: Baking this in from the start allows for us to easily expand to other sources in the future, without adding
  ## much complexity.
  enum source: { hacker_news: "hacker_news" }

  validates :title, :url, :source, :source_id, presence: true

  def self.from_hacker_news(top_story_object:, is_top_story: false)
    hacker_news.new(
      title: top_story_object.title,
      url: top_story_object.url,
      source_id: top_story_object.id,
      is_top_story: is_top_story
    )
  end
end
