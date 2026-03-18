class RebuildQuests < ActiveRecord::Migration[8.1]
  def change
    create_table :quests, id: :uuid do |t|
      t.references :giver,    type: :uuid, null: false, foreign_key: { to_table: :givers }
      t.references :accepter, type: :uuid, null: true,  foreign_key: { to_table: :accepters }

      t.string  :title,         null: false
      t.text    :description
      t.string  :category
      t.string  :status,        null: false, default: "open"
      t.string  :reward_type
      t.decimal :reward_amount, precision: 10, scale: 2
      t.boolean :is_urgent,     default: false
      t.string  :suburb
      t.string  :address_full
      t.datetime :expires_at

      t.datetime :created_at, null: false
    end
  end
end
