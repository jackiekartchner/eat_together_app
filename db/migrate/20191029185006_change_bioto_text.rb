class ChangeBiotoText < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :string, :text
  end
end
