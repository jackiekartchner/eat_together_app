class Booking < ApplicationRecord
  belongs_to :user1, class_name:"User"
  belongs_to :user2, class_name:"User"

  def restaurant
    response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get("https://api.yelp.com/v3/businesses/#{yelp_api_id}")
    yelp_info = response.parse
    restaurant = {
      id: yelp_info["id"],
      name: yelp_info["name"],
      categories: yelp_info["categories"]
    }
  end
end
