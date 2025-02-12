# frozen_string_literal: true

class CreateGroupMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :group_members do |t|
      t.references :member, null: false, foreign_key: { to_table: :users }
      t.references :group, null: false, foreign_key: { to_table: :groups }
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
