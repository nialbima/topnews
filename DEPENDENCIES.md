## Dependencies

This is a list of dependencies I added, with an explanation.

```
gem "hairtrigger"
```

I love this gem! It's a really, really effective way to write and manage DB triggers in Postgres. I wouldn't use them otherwise, because it involves a lot more scripting and isn't apparent from the model.

```
  gem "importmap-rails"
  gem "turbo-rails"
  gem "stimulus-rails
```

This is the hotwired stack, which I love and will reach for by preference in a new Rails app.

```
gem "interactor-rails", "~> 2"
```

This gem is excellent for taking complicated workflows and turning them into simple series of steps. I find that writing these classes guides me towards cleanly separated services, which is a sign of a good design pattern

```
gem "dartsass-rails"
```

Because I'm treating this as a design-agnostic first pass on this project, there's no CSS. That said, `sass-rails` is very, very old at this point, so I replaced it with the current standard and then did nothing else.

```
group :google_comms, :default do
  gem "firebase"
end
```

This is an older gem, but all it does is wrap an HTTP call, so it worked just fine for communicating with HackerNews.

```
gem "dotenv"
gem "whenever", "~> 1.0"
```

We need an effective way to manage periodic background jobs, and this works as long as a machine is running Crontab. `dotenv` is here to make sure that `.env.local` runs in that context; ideally, we'd be able to read it straight from the ENV.

```
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
```

This is my standard setup for writing system + unit tests in Rails.
