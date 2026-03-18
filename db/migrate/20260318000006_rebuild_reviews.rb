class RebuildReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews, id: :uuid do |t|
      t.references :quest,    type: :uuid, null: false, foreign_key: true
      t.references :giver,    type: :uuid, null: false, foreign_key: { to_table: :givers }
      t.references :accepter, type: :uuid, null: false, foreign_key: { to_table: :accepters }

      t.integer :rating,  null: false
      t.text    :comment

      t.datetime :created_at, null: false
    end
  end
end
