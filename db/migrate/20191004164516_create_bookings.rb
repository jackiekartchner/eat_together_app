class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :yelp_api_id
      t.integer :user1_id
      t.integer :user2_id
      t.datetime :appointment

      t.timestamps
    end
  end
end
