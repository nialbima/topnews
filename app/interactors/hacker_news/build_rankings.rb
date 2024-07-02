class HackerNews::BuildRankings
  include Interactor

  delegate :fetched_top_story_ids, to: :context

  def call
    ranking_builder = HackerNews::TopStoryRankingBuilder.new(
      story_ids: fetched_top_story_ids
    )
    ranking_builder.build

    context.current_ranking = ranking_builder.current_ranking
    context.new_ranking = ranking_builder.new_ranking
  end
end
