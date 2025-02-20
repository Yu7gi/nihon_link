class RemoveCheckedFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :checked, :boolean
  end
end
