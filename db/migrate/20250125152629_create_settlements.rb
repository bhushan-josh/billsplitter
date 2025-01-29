class CreateSettlements < ActiveRecord::Migration[7.2]
  def change
    create_table :settlements do |t|
      t.references :payer, null: false, foreign_key: { to_table: :users }
      t.references :payee, null: false, foreign_key: { to_table: :users }
      t.integer :amount

      t.timestamps
    end
  end
end
