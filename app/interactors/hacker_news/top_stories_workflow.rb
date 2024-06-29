module HackerNews
  class TopStoriesWorkflow
    include Interactor::Organizer

    organize FetchTopStories,
      BuildRankings,
      CalculateChanges,
      ProcessCalculatedChangesets,
      UpdateCache
  end
end
