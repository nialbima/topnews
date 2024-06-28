class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      with_options null: false do
        t.string :title
        t.string :url
        t.string :source
        t.integer :source_id
        t.boolean :is_top_story, default: false
      end
      t.timestamps
    end
  end
end
