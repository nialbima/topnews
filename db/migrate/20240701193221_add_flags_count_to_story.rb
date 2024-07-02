class AddFlagsCountToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :flags_count, :integer, null: false, default: 0
  end
end
