class ChangeAdminColumnNull < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :admin, :boolean, default: false, null: true
  end
end
