set :output, "log/cron.log"
set :environment, "development"

every 5.minutes do
  rake "hacker_news:update_top_stories"
end
