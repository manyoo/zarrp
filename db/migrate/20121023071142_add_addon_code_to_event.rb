class AddAddonCodeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :addon_code, :string
  end
end
