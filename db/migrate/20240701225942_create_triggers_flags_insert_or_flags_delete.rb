# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersFlagsInsertOrFlagsDelete < ActiveRecord::Migration[7.0]
  def up
    create_trigger("flags_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("flags").
        after(:insert) do
      <<-SQL_ACTIONS
    UPDATE stories
    SET flags_count = (
      SELECT COUNT(1) FROM flags WHERE story_id = NEW.story_id
    ) WHERE id = NEW.story_id;
      SQL_ACTIONS
    end

    create_trigger("flags_before_delete_row_tr", :generated => true, :compatibility => 1).
        on("flags").
        before(:delete) do
      <<-SQL_ACTIONS
    UPDATE stories
    SET flags_count = (
      SELECT GREATEST(
        (SELECT COUNT(id) FROM flags WHERE story_id = OLD.story_id) -1,
        0
      )
    ) WHERE id = OLD.story_id;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("flags_after_insert_row_tr", "flags", :generated => true)

    drop_trigger("flags_before_delete_row_tr", "flags", :generated => true)
  end
end
