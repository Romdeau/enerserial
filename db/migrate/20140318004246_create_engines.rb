class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.belongs_to :stock
      t.string :engine
      t.string :engine_type
      t.string :serial

      t.timestamps
    end
  end
end
