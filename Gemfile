source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "rails", "~> 7.0.3"

gem "devise"
gem "dotenv"
gem "hairtrigger"
gem "interactor-rails", "~> 2"
gem "jbuilder"
gem "kaminari"
gem "pg"
gem "puma"
gem "redis", ">= 4.0.1"
gem "sidekiq"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "whenever", "~> 1.0"

group :frontend_deps, :default do
  gem "sprockets-rails"
  gem "importmap-rails"
  gem "turbo-rails"
  gem "stimulus-rails"
  gem "dartsass-rails"
end

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
  gem "shoulda-matchers"
end

group :development do
  gem "listen"
  gem "web-console"
  gem "standard"
end
