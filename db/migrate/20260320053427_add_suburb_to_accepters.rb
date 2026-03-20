class AddSuburbToAccepters < ActiveRecord::Migration[8.1]
  def change
    add_column :accepters, :suburb, :string
  end
end
