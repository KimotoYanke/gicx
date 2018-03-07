class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.string :name
      t.string :path
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.string :uid
      t.boolean :is_confirming
      t.boolean :is_passed

      t.timestamps
    end
  end
end
