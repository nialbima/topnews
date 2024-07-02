class HackerNews::ScheduleStoryIngestion
  include Interactor

  delegate :new_top_set, to: :context

  def call
    HackerNews::IngestStoryJob.perform_bulk(new_top_set)
  end
end
