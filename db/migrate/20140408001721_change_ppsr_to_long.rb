class ChangePpsrToLong < ActiveRecord::Migration
  def up
    change_column :stocks, :ppsr, :string
  end

  def down
    change_column :stocks, :ppsr, :integer
  end
end
