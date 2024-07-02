class HackerNews::CalculateChanges
  include Interactor

  delegate :current_ranking, :new_ranking, to: :context

  def call
    changeset = calculated_changesets

    context.new_top_set = changeset.new_top_set
    context.moved_top_set = changeset.moved_top_set
    context.not_top_set = changeset.not_top_set
    context.static_top_set = changeset.static_top_set
  end

  def calculated_changesets
    calculator.calculate_changesets(
      current_ranking: current_ranking, new_ranking: new_ranking
    )
  end

  def calculator
    HackerNews::StoryChangesetCalculator
  end
end
