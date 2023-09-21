class ChangeColumnNameInAsset < ActiveRecord::Migration[6.0]
  def change
      rename_column :assets, :type, :stuff
  end
end
