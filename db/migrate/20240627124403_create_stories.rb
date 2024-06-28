class CreateStories < ActiveRecord::Migration[7.0]
  def change
    ## We can use an ALTER query to update this value in the event that we want to add more enums.
    ## In general, I like adding enums that aren't only legible to developers where possible. It's
    ## probably overkill here, but it's not hard.
    create_enum :story_source, ["hacker_news"]

    create_table :stories do |t|
      with_options null: false do
        t.string :title
        t.string :url
        t.enum :source, enum_type: :story_source, default: "hacker_news", index: true, null: false
        t.integer :source_id
        t.boolean :is_top_story, default: false
      end
      t.timestamps
    end
  end
end
