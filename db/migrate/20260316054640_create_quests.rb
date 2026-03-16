class CreateQuests < ActiveRecord::Migration[8.1]
  def change
    create_table :quests do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :reward
      t.string :status, null: false, default: "open"
      t.string :category
      t.string :location
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
