source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "rails", "~> 7.0.3"

gem "devise"
gem "pg"
gem "puma"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "redis", ">= 4.0.1"
gem "kredis"
gem "sidekiq"

## I see no reason to alter the default JSON parser. Oj is more performant and invisible.
gem "jbuilder"
gem "oj"
gem "kaminari"
gem "hairtrigger"

gem "faraday"
gem "typhoeus"

# This is a lightweight, simple gem that makes it easy to destructure complex services into neatly organized steps.
gem "interactor-rails", "~> 2"

group :frontend_deps, :default do
  ## Sprockets shouldn't be necessary once on Rails 7 with importmap-rails, but I'm including it for now to avoid debugging
  ## asset pipeline issues that aren't pertinent for the task at hand.
  gem "sprockets-rails"
  gem "importmap-rails"
  gem "turbo-rails"
  gem "stimulus-rails"

  ## sass-rails and sassc-rails are both EOL, and I wanted to make sure that the asset pipeline was configured correctly
  ## given that I'm adding the Hotwired stack. So I swapped it out for the current version of dartsass-rails, which is a
  ### modern and well-supported replacement for sass-rails/sassc-rails.
  gem "dartsass-rails"
end

## NOTE: I'm not sure we need an actual Firebase-responsive HTTP interaction here. The Ruby support can be rough for
## Google Cloud products.

## The question would be whether we can get live-data notifications from HackerNews, which is likely possible but doesn't seem
## worthwhile when we can interact exclusively with JSON. I don't see a way to configure a webhook notification when top
## stories change in a public API; all the docs seem focused on receiving that notification when working with an
## internal database.

## If that WERE possible, we'd configure Firestore to accurately query the API and see about hooking up live notifications.
## For now, I'm going with the simple wrapper, retrieving the JSON, and parsing it.
##
## There's also the question of gRPC, which is the main reason why I spent time investigating the Google Cloud Firestore gem.
## Protobufs are extremely powerful and I'd like to use them if possible. But it ultimately felt like a digression that
## didn't add much to the task.
##
# gem "google-cloud-firestore"
# gem "grpc"

group :google_comms, :default do
  gem "firebase"
end

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails"
  gem "ffaker"
end

group :test do
  gem "vcr"
  gem "webmock"
  gem "cuprite"
  gem "rspec-rails"
  # I'm including this because it has some helpful matchers.
  gem "shoulda-matchers"
end

group :development do
  gem "listen"
  gem "web-console"
  gem "standard"
end

gem "whenever", "~> 1.0"
