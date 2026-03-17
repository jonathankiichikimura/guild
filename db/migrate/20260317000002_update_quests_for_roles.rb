class UpdateQuestsForRoles < ActiveRecord::Migration[8.1]
  def change
    rename_column :quests, :user_id, :quest_giver_id
    add_column :quests, :quest_accepter_id, :bigint
    add_column :quests, :experience, :integer

    add_index :quests, :quest_accepter_id
    add_foreign_key :quests, :users, column: :quest_accepter_id
  end
end
