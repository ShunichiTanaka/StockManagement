class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
			t.integer :stock_account_id, null: false
			t.integer :brand_id, null: false
			t.integer :status, null: false
			t.date :trade_at, null:false, default: 0
			t.integer :contract_price, null: false
			t.integer :trade_sum, null: false
			t.integer :sales_price, null: false
			t.integer :charges, null: false
			t.date :payment_at
			t.integer :payment_price
			t.float :profit_ratio
			t.text :info

      t.timestamps null: false
    end
  end
end
