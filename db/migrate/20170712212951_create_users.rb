class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default: ''
      t.string :last_name
      t.string :username, null: false, default: ''      
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''

      t.index :username, unique: true
      t.index :email, unique: true

      t.timestamps
    end
  end
end
