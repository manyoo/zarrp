class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :time
      t.string :club
      t.string :address
      t.string :short_desc
      t.string :desc
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
