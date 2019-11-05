class Booking < ApplicationRecord
  belongs_to :user1, class_name:"User"
  belongs_to :user2, class_name:"User"

  def restaurant
    response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get("https://api.yelp.com/v3/businesses/#{yelp_api_id}")
    yelp_info = response.parse
    restaurant = {
      id: yelp_info["id"],
      image_url: yelp_info["image_url"],
      name: yelp_info["name"],
      price: yelp_info["price"],
      display_address: yelp_info["location"]["display_address"].join(' '),
      display_phone: yelp_info["display_phone"],
      url: yelp_info["url"],
     categories: yelp_info["categories"].map { |category| category["title"] }.join(", ")
    }
  end
end







