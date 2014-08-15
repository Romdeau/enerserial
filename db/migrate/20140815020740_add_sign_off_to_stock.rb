class AddSignOffToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :accounts_signoff, :integer
    add_column :stocks, :projects_signoff, :integer
  end
end
