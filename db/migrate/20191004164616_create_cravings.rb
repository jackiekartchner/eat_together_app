class CreateCravings < ActiveRecord::Migration[6.0]
  def change
    create_table :cravings do |t|
      t.integer :radius
      t.string :category
      t.string :price
      t.integer :user_id
      t.datetime :appointment

      t.timestamps
    end
  end
end
