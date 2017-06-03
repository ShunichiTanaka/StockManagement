class CreateTradingHistories < ActiveRecord::Migration
  def change
    create_table :trading_histories, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.date :purchase_date, null: false
      t.integer :code, null: false
      t.integer :purchase_price, null: false
      t.integer :stock_number, null: false
      t.date :disposal_date
      t.integer :disposal_price
      t.integer :profit

      t.timestamps null: false
    end
  end
end
