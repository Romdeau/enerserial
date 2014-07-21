class AddPmToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :project_manager, :reference
  end
end
