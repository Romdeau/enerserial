class AddPmToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :project_manager, :string
  end
end
