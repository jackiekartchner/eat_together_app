class AddImageUrlToCravings < ActiveRecord::Migration[6.0]
  def change
    add_column :cravings, :craving_url, :string
  end
end
