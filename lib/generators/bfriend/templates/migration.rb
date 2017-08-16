class Create Bfriends < ActiveRecord::Migration[1.0]
    def change
        create_table :bfriends  do |t|
        t.integer :user_id
        t.integer :bfriend_id
        t.timestamps null: false
        end
    end
end