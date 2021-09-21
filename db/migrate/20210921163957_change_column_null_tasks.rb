class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, null: false, limit: 30
  end
end
