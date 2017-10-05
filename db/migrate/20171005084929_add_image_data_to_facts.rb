class AddImageDataToFacts < ActiveRecord::Migration[5.1]
  def change
    add_column :facts, :image_data, :string
  end
end
