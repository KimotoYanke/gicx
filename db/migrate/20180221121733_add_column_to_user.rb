class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :homeroom, foreign_key: true
  end
end
