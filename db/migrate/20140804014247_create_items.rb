class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :item_model
      t.string :item_serial
      t.string :stock_type
      t.references :order, index: true
      t.string :distributor
      t.string :manufacturer
      t.references :stock, index: true

      t.timestamps
    end
  end
end
