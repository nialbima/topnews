# CORE OBJECTS

## DB Models

- Story knows its source, its rank and its url. It uses a Postgres enum to dgit lefine the source in order to allow for later additions (or not, but this avoids a migration down the line).

## PORO Models

- A HackerNews::TopStory is a Ruby object containing the attributes of a single hacker news story. It behaves like a normal Ruby model, but is not persisted to the database. It's used for conversion. This is a good way to map response data to an AR-backed class without adding a bunch of complex overhead.
  - I added two simple custom types to help with conversion here.

## Interactors

- TopStoriesWorkflow organizes all the steps in ingestion:
  - FetchTopStories hits the HackerNews API
  - BuildRankings sets up the objects we need to evaluate to figure out what changed
  - CalculateChanges figures out what changed by iterating over teh
    - I'm not thrilled with this implementation, but it's fully tested and it's producing valid results, so it's fine for now. I have some more context/info in Algorithm Notes below.
  - ProcessCalculatedChangesets passes the changesets to the appropriate workers.
  - UpdateCache updates the cache
    - I did this in a separate step because I don't always love using `.fetch` to interact with a stored Redis key.
- IngestTopStory triggers the StoryFetcher, maps the response as a TopStory, converts the parsed response to an AR Story object, and saves it.
  - This happens in a background job based on tuples passed into `.perform_bulk`.

## Service Objects

- HackerNews::TopStoryRankingBuilder indexes the HN API response with a rank, and loads the cached rankings (unless there's a cache miss, in which case the current set is loaded and we re-ingest everything).
- HackerNews::StoryFetcher uses the Firebase gem to get the data from HackerNews.

# Algorithm Notes

The calculator compares two sets of rankings and determines which stories are new, which have moved, and which are no longer top stories.

So for these arguments:

Current Ranking:

`[[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]`

New Ranking:

`[[0, 66], [1, 254], [2, 99], [3, 188], [4, 221], [5, 132]]`

We'd expect these results:

- new_top_set = [[1, 254], [4, 221]],
- moved_top_set = [[0, 66], [3, 188], [5, 132]],
- not_top_set = [[0, 33], [4, 155]],
- static_top_set = [[2, 99]]

I don't love the approach I took here. It wasn't worth spending any more time working out a more efficient algorithm, because the maximum size of the array in the API response is only ever 500 entries. With that said, I think that suggests that my focus on avoiding casting the array to a hash to avoid creating new objects in memory was unwarranted. I wanted to take the list, use list position as index rank, and then go through the entire set to determine the state of each entry without doing unnecessary work.

On reflection, I don't think I quite achieved what I wanted. It's pretty ugly. If I were reviewing this, I'd probably add the following comments:

- Needing to break in order to stop iteration isn't pleasing at all.
- `.delete_at` will reduce the size of the data set on each iteration, but Ruby will need to recalculate the Array size, which would suggest that this isn't a good idea on larger datasets. We could achieve something similar by writing the tuple `[nil, nil]` to the array at a given index, which shouldn't require Ruby to recalculate the whole thing.
- This isn't actually using tuples, it's just mimicking the data structure. It might be beneficial to use something a little more strongly typed here, but that might also point to the need to just use a hash for O(n) lookup. It's adding complexity where it's not needed.

In the interest of seeing what it thought, I asked Github Copilot to give me a version of the algorithm. It produced the following:

```ruby
def determine_top_set_according_to_copilot
  current_ranking_hash = current_ranking.to_h { |rank, id| [id, rank] }
  new_ranking_hash = new_ranking.to_h { |rank, id| [id, rank] }

  new_ranking.each do |new_rank, new_id|
    if current_ranking_hash.key?(new_id)
      if current_ranking_hash[new_id] != new_rank
        moved_top_set << [new_rank, new_id]
      else
        static_top_set << [new_rank, new_id]
      end
      current_ranking_hash.delete(new_id)
    else
      new_top_set << [new_rank, new_id]
    end
  end
```

And I don't hate it. I dislike doing type conversions if I don't need to, but it seems appropriate here. I'd need to do some performance testing to figure out which one was better, but that was overkill. So I left The algorithm alone as something to talk about in the technical review.
