class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :quest, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment
      t.bigint :reviewer_id, null: false
      t.bigint :reviewee_id, null: false

      t.timestamps
    end

    add_index :reviews, [:quest_id, :reviewer_id], unique: true
    add_index :reviews, :reviewer_id
    add_index :reviews, :reviewee_id
  end
end
