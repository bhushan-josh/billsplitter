# frozen_string_literal: true

class AddDobToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :dob, :date
  end
end
