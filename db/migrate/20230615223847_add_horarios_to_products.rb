# frozen_string_literal: true

class AddHorariosToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :fecha, :date
    add_column :products, :hora_inicio, :time
    add_column :products, :hora_fin, :time
  end
end
