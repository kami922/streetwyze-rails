class RenameAssetToPost < ActiveRecord::Migration[6.0]
  def change
    rename_table :assets ,:posts
  end
end
