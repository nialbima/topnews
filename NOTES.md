        # NOTE: This looks non-optimal, so I asked Copilot for its opinion. Object lookups seem possible as an approach.
        # We're only dealing with a list of length 500, so I'm not going to spend any more time thinking about it, but I kind
        # of think the AI did a better job here.
        #
        # def determine_top_set_according_to_copilot
        #   current_ranking_hash = current_ranking.to_h { |rank, id| [id, rank] }
        #   new_ranking_hash = new_ranking.to_h { |rank, id| [id, rank] }

        #   new_ranking.each do |new_rank, new_id|
        #     if current_ranking_hash.key?(new_id)
        #       if current_ranking_hash[new_id] != new_rank
        #         moved_top_set << [new_rank, new_id]
        #       else
        #         static_top_set << [new_rank, new_id]
        #       end
        #       current_ranking_hash.delete(new_id)
        #     else
        #       new_top_set << [new_rank, new_id]
        #     end
        #   end

        #   self.not_top_set = current_ranking_hash.map { |id, rank| [rank, id] }
        # end
