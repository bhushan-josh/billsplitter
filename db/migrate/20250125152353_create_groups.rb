class CreateGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.text :description

      t.timestamps
    end
  end
end
