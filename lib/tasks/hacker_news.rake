namespace :hacker_news do
  task update_top_stories: :environment do
    puts "Updating top stories..."
    HackerNews::TopStoriesWorkflow.call
    puts "Top stories updated!"
  end
end
