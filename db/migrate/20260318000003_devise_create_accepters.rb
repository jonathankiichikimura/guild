class DeviseCreateAccepters < ActiveRecord::Migration[8.1]
  def change
    create_table :accepters, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Profile fields
      t.string  :full_name
      t.string  :avatar_url
      t.string  :phone_verified
      t.string  :id_verified
      t.string  :trust_tier
      t.float   :rating_average
      t.integer :quests_completed, default: 0

      t.timestamps null: false
    end

    add_index :accepters, :email,                unique: true
    add_index :accepters, :reset_password_token, unique: true
  end
end
