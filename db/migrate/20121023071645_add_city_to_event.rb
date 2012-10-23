class AddCityToEvent < ActiveRecord::Migration
  def change
    add_column :events, :city, :string
    add_index :events, :city
  end
end
