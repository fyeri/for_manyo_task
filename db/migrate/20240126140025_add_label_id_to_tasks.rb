class AddLabelIdToTasks < ActiveRecord::Migration[6.0]
  def change
      add_column :tasks, :label_id, :integer
  end
end
