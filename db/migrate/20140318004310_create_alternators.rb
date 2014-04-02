class CreateAlternators < ActiveRecord::Migration
  def change
    create_table :alternators do |t|
      t.belongs_to :stock
      t.string :alternator
      t.string :alternator_type
      t.string :serial

      t.timestamps
    end
  end
end