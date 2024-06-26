# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end
  end
end
