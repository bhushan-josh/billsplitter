class CreateGroupMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :group_members do |t|
      t.references :group_id, null: false, foreign_key: { to_table: :groups }
      t.references :member, null: false, foreign_key: { to_table: :users }
      t.integer :role

      t.timestamps
    end
  end
end
