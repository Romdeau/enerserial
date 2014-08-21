class DropAlternatorsAndEngines < ActiveRecord::Migration
  def up
    drop_table :alternators
    drop_table :engines
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
