class AddForeignKeyToStories < ActiveRecord::Migration[6.0]
  def change
    add_reference :stories, :user, foreign_key: true
    add_reference :stories, :post, foreign_key: true
  end
end
