class ChangeColumnNameInStory < ActiveRecord::Migration[6.0]
  def change
    rename_column :stories, :type, :stuff
  end
end
