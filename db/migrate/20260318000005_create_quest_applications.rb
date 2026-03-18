class CreateQuestApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :quest_applications, id: :uuid do |t|
      t.references :quest,    type: :uuid, null: false, foreign_key: true
      t.references :accepter, type: :uuid, null: false, foreign_key: { to_table: :accepters }

      t.string :status,  null: false, default: "pending"
      t.text   :message

      t.datetime :created_at, null: false
    end
  end
end
