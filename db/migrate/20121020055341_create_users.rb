class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :access_token

      t.timestamps
    end
    add_index :users, :access_token, :uniqe => true
  end
end
