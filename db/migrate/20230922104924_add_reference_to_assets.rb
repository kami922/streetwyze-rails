class AddReferenceToAssets < ActiveRecord::Migration[6.0]
  def change
    add_reference :assets ,:user, foreign_key: true
  end
end
