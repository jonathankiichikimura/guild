class EnablePgcryptoAndDropLegacy < ActiveRecord::Migration[8.1]
  def up
    # Remove FK constraints before dropping tables
    remove_foreign_key "quests", column: "quest_accepter_id"
    remove_foreign_key "quests", column: "quest_giver_id"
    remove_foreign_key "reviews", "quests"

    drop_table :reviews
    drop_table :quests
    drop_table :users

    enable_extension "pgcrypto"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
