# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.references :payer, null: false, foreign_key: { to_table: :users }
      t.references :expense_group, null: false, foreign_key: { to_table: :groups }
      t.integer :amount
      t.text :description

      t.timestamps
    end
  end
end
