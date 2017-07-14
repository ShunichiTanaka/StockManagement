class AddIndexToStockPrice < ActiveRecord::Migration
  def change
    add_index :stock_prices, [:target_date, :code]
  end
end
