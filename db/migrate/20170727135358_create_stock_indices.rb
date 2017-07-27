class CreateStockIndices < ActiveRecord::Migration
  def change
    create_table :stock_indices, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.date :target_date, null: false
      t.float :nikkei, null: false
      t.float :topix, null: false
      t.float :mothers, null: false
      t.float :jasdaq, null: false
      t.float :two_department, null: false

      t.timestamps null: false
    end
  end
end
