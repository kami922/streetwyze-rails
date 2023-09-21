class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :place_name
      t.string :address
      t.string :type
      t.string :category
      t.integer :rating
      t.string :description , limit: 2000

      t.timestamps
    end
  end
end
