class AddNeedsPpsrToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :needs_ppsr, :boolean, :default => true
  end
end
