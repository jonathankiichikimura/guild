class DeviseCreateGivers < ActiveRecord::Migration[8.1]
  def change
    create_table :givers, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Profile fields
      t.string :first_name
      t.string :avatar_url
      t.string :suburb
      t.string :emergency_contact_name
      t.string :emergency_contact_phone

      t.timestamps null: false
    end

    add_index :givers, :email,                unique: true
    add_index :givers, :reset_password_token, unique: true
  end
end
