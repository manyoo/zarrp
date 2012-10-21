class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :default_currency
      t.date   :date_of_birth
      t.string :access_token

      t.timestamps
    end
    add_index :users, :access_token, :uniqe => true
  end
end
