class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  change_column_null :tasks, :title, false
  change_column_null :tasks, :content, false
end
