class Craving < ApplicationRecord
  belongs_to :user

  def match
    #return the craving match OR return nill
    #add satisfied = false
    cravings = Craving.where("category = ? AND appointment = ? AND id != ? AND user_id != ?", category, appointment, id, user_id)
    if price.length > 1
      cravings = cravings.where("price = ? OR price = ?", price, price.chop)
    else 
      cravings = cravings.where("price = ?", price)
    end
    cravings.each do |craving|
      if craving.user.zip_code == user.zip_code
        return craving
      end 

    end
    return nil
  end

  # def satisfied(user1, user2)
  #   craving1 = Craving.find_by(user_id: user1)
  #   craving1.satisfied = true
  #   craving2 = Craving.find_by(user_id: user2)
  #   craving2.satisfied = true
  # end

  def yelp_api_id
    response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get("https://api.yelp.com/v3/businesses/search?location=#{user.zip_code}&categories=#{category.downcase}&price=#{price.length},#{price.chop.length}")
    yelp_info = response.parse["businesses"].sample["id"]
    return yelp_info
  end

  def category_image
    response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get("https://api.yelp.com/v3/businesses/search?location=#{user.zip_code}&categories=#{category.downcase}")
    yelp_image = response.parse["businesses"].sample["image_url"]
    return yelp_image
  end
end
