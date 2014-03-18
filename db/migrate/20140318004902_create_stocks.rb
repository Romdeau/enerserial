class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :serial_number
      t.belongs_to :job, index: true
      t.string :detail
      t.string :status
      t.string :status_detail
      t.string :gesan_number
      t.integer :ppsr

      t.timestamps
    end
  end
end
