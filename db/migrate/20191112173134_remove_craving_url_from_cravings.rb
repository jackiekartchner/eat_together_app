class RemoveCravingUrlFromCravings < ActiveRecord::Migration[6.0]
  def change
    remove_column :cravings, :craving_url, :string
  end
end
