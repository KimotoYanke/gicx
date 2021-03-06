class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :until
      t.references :subject, foreign_key: true
      t.text :users

      t.timestamps
    end
  end
end
