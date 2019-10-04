# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(full_name: "Jackie Kartchner", phone_number: "925-890-0987", email: "jackie@gmail.com", zip_code: "94588")
User.create(full_name: "Kevin Miller", phone_number: "801-345-2323", email: "kevin@gmail.com", zip_code: "94566")
User.create(full_name: "Michael Jordan", phone_number: "960-234-7856", email: "jordan@gmail.com", zip_code: "90912")

Booking.create(yelp_api_id: "yhuGN7ndwX33MZmr0Q1wQw", user1_id: 1, user2_id: 2, appointment: Time.now)
Booking.create(yelp_api_id: "8kfLRdbByaxrIEvyS3jrnw", user1_id: 2, user2_id: 1, appointment: Time.now)
Booking.create(yelp_api_id: "6ntO8HOMgiJfLw5Cjisk_w", user1_id: 3, user2_id: 1, appointment: Time.now)

Craving.create(radius: 2000, category: "American", price: "$$", user_id: 1, appointment: Time.now)
Craving.create(radius: 3000, category: "Afghan", price: "$$$", user_id: 2, appointment: Time.now)
Craving.create(radius: 4000, category: "Mediterranean", price: "$", user_id: 3, appointment: Time.now)