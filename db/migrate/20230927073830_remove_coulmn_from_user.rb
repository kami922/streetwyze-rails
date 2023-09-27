class RemoveCoulmnFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users , :email , :password
  end
end
