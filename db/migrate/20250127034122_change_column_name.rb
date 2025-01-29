# frozen_string_literal: true

class ChangeColumnName < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :phone, :phone_no
  end
end
