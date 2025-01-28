class CreateExpenseSplits < ActiveRecord::Migration[7.2]
  def change
    create_table :expense_splits do |t|
      t.references :expense_id, null: false, foreign_key: { to_table: :expenses }
      t.references :payee, null: false, foreign_key: { to_table: :users }
      t.integer :amount
      t.integer :status

      t.timestamps
    end
  end
end
