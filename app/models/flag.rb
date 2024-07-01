class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :story, counter_cache: true

  # trigger.after(:insert) do
  #   "UPDATE stories SET flags_count = flags_count + 1 WHERE id = NEW.story_id;"
  # end

  # trigger.after(:destroy) do
  #   "UPDATE stories SET flags_count = MAX(flags_count - 1, 0) WHERE id = NEW.story_id;"
  # end


end
