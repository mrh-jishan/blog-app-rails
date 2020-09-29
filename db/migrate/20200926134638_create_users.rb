class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :email

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
