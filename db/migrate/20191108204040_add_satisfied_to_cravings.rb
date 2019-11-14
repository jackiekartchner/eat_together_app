class AddSatisfiedToCravings < ActiveRecord::Migration[6.0]
  def change
    add_column :cravings, :satisfied, :boolean
    Craving.all.each do |craving|
      craving.update_attributes!(:satisfied => 'false')
    end
  end
end
