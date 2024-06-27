## A HackerNews::Story is a Ruby object containing the attributes of a single hacker news story. It behaves like a normal
## Ruby model, but is not persisted to the database. It's used for conversion. This is a good way to map response data
## to an AR-backed class without adding a bunch of complex overhead.

module HackerNews
  class Story
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :title, :string
    attribute :url, :string
    attribute :score, :integer
    attribute :by, :string
    attribute :time, :epoch_time
    attribute :type, :string
    attribute :descendants, :integer
    # You can't use array: true without access to the Postgres db. A simple cast solves it.
    attribute :kids, :array_of_integers
  end
end
