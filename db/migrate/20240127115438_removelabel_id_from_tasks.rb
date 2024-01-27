class RemovelabelIdFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :label_id, :integer
  end
end
