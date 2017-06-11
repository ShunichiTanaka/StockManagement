class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name, null: false
      t.text :info

      t.timestamps null: false
    end
  end
end
