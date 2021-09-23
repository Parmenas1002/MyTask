class AddExpiredDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expiredDate, :datetime, default: Time.now
  end
end
