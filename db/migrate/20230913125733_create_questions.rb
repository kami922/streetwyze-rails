class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :statement
      t.references :survey, foreign_key: true, null: false


      t.timestamps
    end
  end
end
