class RemoveJpLevelFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :jp_level, :integer
  end
end
