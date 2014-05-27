class CreateStockAudits < ActiveRecord::Migration
  def change
    create_table :stock_audits do |t|
      t.references :stock, index: true
      t.references :engine, index: true
      t.references :alternator, index: true
      t.references :user, index:true
      t.string :comment

      t.timestamps
    end
  end
end
