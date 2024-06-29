class AddRankToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :rank, :integer, index: true
  end
end
