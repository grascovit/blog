class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :message, null: false, default: ''
      t.integer :action, null: false, default: 0
      t.references :user, foreign_key: true
      t.timestamp :read_at

      t.timestamps
    end
  end
end
