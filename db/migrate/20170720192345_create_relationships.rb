class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, index: true
      t.integer :following_id, index: true

      t.timestamps
    end

    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
