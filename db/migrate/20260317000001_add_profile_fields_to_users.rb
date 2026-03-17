class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :username, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :total_xp, :integer, default: 0, null: false
    add_column :users, :avg_rating, :decimal, precision: 3, scale: 2

    add_index :users, :username, unique: true
  end
end
