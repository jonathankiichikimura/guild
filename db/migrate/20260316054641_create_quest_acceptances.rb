class CreateQuestAcceptances < ActiveRecord::Migration[8.1]
  def change
    create_table :quest_acceptances do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: "active"

      t.timestamps
    end

    add_index :quest_acceptances, [:quest_id, :user_id], unique: true
  end
end
