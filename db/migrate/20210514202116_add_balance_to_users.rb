# frozen_string_literal: true

class AddBalanceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :balance, :float, null: false, default: 0
  end
end
