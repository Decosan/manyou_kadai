class AddColumnSortExpiredToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :sort_expired, :date, default: (Time.now + 1.day), null: false
  end
end
