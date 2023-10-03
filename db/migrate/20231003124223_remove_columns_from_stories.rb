class RemoveColumnsFromStories < ActiveRecord::Migration[6.0]
  def change
    remove_column :stories, :user_id, :integer
    remove_column :stories, :asset_id, :integer
    remove_column :stories, :post_id, :integer
  end
end
