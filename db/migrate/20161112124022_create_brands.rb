class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
			t.string :name, null: false
			t.integer :code, null: false, unique: true
			t.text :info

      t.timestamps null: false
    end
  end
end
