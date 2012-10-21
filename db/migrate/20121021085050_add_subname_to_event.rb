class AddSubnameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :subname, :string
  end
end
