namespace :hacker_news do
  task update_top_stories: :environment do
    HackerNews::TopStoriesWorkflow.call
  end
end
