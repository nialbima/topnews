class HackerNews::ProcessCalculatedChangesets
  include Interactor

  delegate :moved_top_set, :not_top_set, :new_top_set, to: :context

  def call
    HackerNews::IngestStoryJob.perform_bulk(new_top_set) if new_top_set.any?
    HackerNews::UpdateStoryJob.perform_bulk(moved_top_set) if moved_top_set.any?
    HackerNews::DemoteStoriesJob.perform_async(not_top_set) if not_top_set.any?
  end
end
