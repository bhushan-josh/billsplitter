# frozen_string_literal: true

class CreateExpenseSplits < ActiveRecord::Migration[7.2]
  def change
    create_table :expense_splits do |t|
      t.references :expense, null: false, foreign_key: { to_table: :expenses }
      t.references :payer, null: false, foreign_key: { to_table: :users }
      t.references :payee, null: false, foreign_key: { to_table: :users }
      t.integer :amount
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
