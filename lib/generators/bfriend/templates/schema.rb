ActiveRecord::Schema.define(:version => 1.0) do

     create_table :bfriends  do |t|
      t.integer :user_id
      t.integer :bfriend_id
      t.timestamps null: false
    end
    
end
