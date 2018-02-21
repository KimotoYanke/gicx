class CreateHomerooms < ActiveRecord::Migration[5.1]
  def change
    create_table :homerooms do |t|
      t.integer :grade
      t.string :depertment

      t.timestamps
    end
  end
end
