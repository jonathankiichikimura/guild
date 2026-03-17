class DropQuestAcceptances < ActiveRecord::Migration[8.1]
  def change
    drop_table :quest_acceptances do |t|
      t.bigint :quest_id, null: false
      t.bigint :user_id, null: false
      t.string :status, default: "active", null: false
      t.timestamps
    end
  end
end
