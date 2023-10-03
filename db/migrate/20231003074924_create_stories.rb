class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.text :description
      t.integer :rating
      t.integer :asset_id
      t.integer :user_id
      t.string :place_name
      t.string :address
      t.string :type
      t.string :category

      t.timestamps
    end
  end
end
