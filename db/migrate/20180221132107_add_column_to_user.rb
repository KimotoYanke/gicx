class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :homeroom_id, :integer
  end
end
