class Story < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :flagging_users, through: :flags, source: :user

  validates :title, :url, :source, :source_id, presence: true
  validates :source_id, uniqueness: {scope: [:source]}

 enum source: {hacker_news: "hacker_news"}

  scope :top_stories_with_rank, -> { where(is_top_story: true).order(:rank) }
  scope :flagged_stories, -> { where(flags_count: (1...)).order(flags_count: :desc) }

  def self.ranked_top_story_ids
    top_stories_with_rank.pluck(:rank, :source_id)
  end

  def self.from_hacker_news(top_story_object:, is_top_story: false)
    hacker_news.new(
      title: top_story_object.title,
      url: top_story_object.url,
      source_id: top_story_object.id,
      rank: top_story_object.rank,
      is_top_story: is_top_story
    )
  end

  def flagged_by_user?(user)
    flagging_users.include?(user)
  end

  def flagged?
    flags_count > 0
  end

  def hacker_news_link
    "news.ycombinator.com/item?id=#{source_id}"
  end

  def flagger_names(current_user)
    base_message = current_user.in?(flagging_users) ? "You" : nil
    other_flaggers = flagging_users.where.not(id: current_user.id).pluck(:first_name)
    [base_message, other_flaggers].flatten.compact.join(", ")
  end
end
