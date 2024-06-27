# CORE OBJECTS

## DB Models

- Story knows its source and its url. It uses a Postgres enum to define the source in order to allow for later additions (or not, but this avoids a migration down the line).

## PORO Models

- A HackerNews::TopStory is a Ruby object containing the attributes of a single hacker news story. It behaves like a normal Ruby model, but is not persisted to the database. It's used for conversion. This is a good way to map response data to an AR-backed class without adding a bunch of complex overhead.
  - I added two simple custom types to help with conversion here.

## Service Objects

- HackerNews::StoryFetcher uses the Firebase gem to get the data from HackerNews.
