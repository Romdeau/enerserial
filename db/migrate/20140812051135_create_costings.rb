class CreateCostings < ActiveRecord::Migration
  def change
    create_table :costings do |t|
      t.string :foreign_cost
      t.string :exchange_rate
      t.string :markup
      t.string :landed_cost
      t.references :stock, index: true

      t.timestamps
    end
  end
end
