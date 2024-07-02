## NOTE: This calculator is designed to determine the changes in the top stories on HackerNews. It's a simple algorithm that
## compares the current top stories to the new top stories and determines which stories are new, which have moved, and which
## are no longer top stories.
##
## Here's a breakdown of the algorithm:
## Current Ranking: [[0, 33], [1, 66], [2, 99], [3,155]]
## New Ranking: [[0, 66], [1, 33], [2, 132], [3, 188]]
##
## New: [0, 66]
## first sub-loop: current ranking is [0, 33].
##   condition 1 - current id is 33, new id is 66. They don't match.
##   condition 2 - new rank is equal to current rank, but more elements exist to check in the remaining_current_rankings
##   array, so we break.
## second sub-loop: current ranking is [1, 66]
##   condition 1 - current id is 66, new id is 66. They match. We add the new ranking to the moved_top_set, delete [1, 66]
##   from the remaining_current_rankings, and break.
## Done checking for new ranking. remaining_current_rankings is now [[0, 33], [2, 99], [3,155]].
##
## New: [1, 33]
## first sub-loop: current ranking is [0, 33].
##  condition 1 - current id is 33, new id is 33. They match. We add the new ranking to the moved_top_set, delete [0, 33]
## from the remaining_current_rankings, and break. We don't care
## Done checking for new ranking. remaining_current_rankings is now [[2, 99], [3,155]].
##
## New: [2, 132]
## first sub-loop: old is [2, 99], cursor is nil, detected_ranking is nil.
## remaining_current_rankings is now [[2, 99]]. End parent loop, not found.
##
## expected results: new_top_set = [[2, 132]], moved_top_set = [[0, 66], [1, 33]], not_top_set = [[2, 99]
module HackerNews
  class StoryChangesetCalculator
    attr_reader :current_ranking, :new_ranking
    attr_accessor :new_top_set, :not_top_set, :moved_top_set, :static_top_set

    def self.calculate_changesets(...)
      calculator = new
      calculator.run(...)
      calculator
    end

    def initialize
      self.new_top_set = []
      self.moved_top_set = []
      self.static_top_set = []
      self.not_top_set = []
    end

    def run(current_ranking:, new_ranking:)
      @current_ranking = current_ranking
      @new_ranking = new_ranking

      calculate_changesets(current_ranking: current_ranking, new_ranking: new_ranking)
    end

    protected

    def calculate_changesets(current_ranking:, new_ranking:)
      if current_ranking.blank?
        self.new_top_set = new_ranking
      else
        configured_enum = new_ranking.each_with_object(current_ranking.dup).with_index

        self.not_top_set = configured_enum.each do |(rank_in_new_set, remaining_current_rankings), index_in_new_set|
          new_rank, new_id = rank_in_new_set

          remaining_current_rankings.each.with_index do |current_ranking, index|
            current_rank, current_id = current_ranking

            if current_id == new_id && current_rank != new_rank
              moved_top_set << rank_in_new_set
              remaining_current_rankings.delete_at(index)
              break
            elsif current_id == new_id && current_rank == new_rank
              static_top_set << rank_in_new_set
              remaining_current_rankings.delete_at(index)
              break
            elsif current_id != new_id && remaining_current_rankings[index + 1].nil?
              new_top_set << rank_in_new_set
              break
            end
          end
        end
      end
    end
  end
end
