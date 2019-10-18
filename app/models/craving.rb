class Craving < ApplicationRecord
  belongs_to :user

  def match
    #return the craving match OR return nill
    cravings = Craving.where("category = ? AND appointment = ? AND id != ?", category, appointment, id)
    cravings.each do |craving|
      if craving.user.zip_code == user.zip_code
        return craving
      end 

    end
    return nil
  end

  def yelp_api_id
    response = HTTP.auth("Bearer #{ENV["YELP_API_KEY"]}").get("https://api.yelp.com/v3/businesses/search?location=#{user.zip_code}&categories=#{category}")
    yelp_info = response.parse["businesses"][1]["id"]
    return yelp_info
  end
end
