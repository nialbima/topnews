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
