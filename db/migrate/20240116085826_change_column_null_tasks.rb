class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  # change_column_null :tasks, :title, null: false
  # change_column_null :tasks, :content, null: false

  change_column :tasks, :title, :string, null: false
  change_column :tasks, :content, :string, null: false
end
