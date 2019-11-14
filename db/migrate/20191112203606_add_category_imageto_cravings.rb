class AddCategoryImagetoCravings < ActiveRecord::Migration[6.0]
  def change
    add_column :cravings, :category_image, :string
  end
end
