class Flag < ApplicationRecord
  INSERT_FLAG_TRIGGER_STATEMENT = <<-SQL
    UPDATE stories
    SET flags_count = (
      SELECT COUNT(1) FROM flags WHERE story_id = NEW.story_id
    ) WHERE id = NEW.story_id;
  SQL

  DELETE_FLAG_TRIGGER_STATEMENT = <<-SQL
    UPDATE stories
    SET flags_count = (
      SELECT GREATEST(
        (SELECT COUNT(id) FROM flags WHERE story_id = OLD.story_id) -1,
        0
      )
    ) WHERE id = OLD.story_id;
  SQL

  belongs_to :user
  belongs_to :story

  trigger.after(:insert) do
    INSERT_FLAG_TRIGGER_STATEMENT
  end

  trigger.before(:destroy) do
    DELETE_FLAG_TRIGGER_STATEMENT
  end
end
