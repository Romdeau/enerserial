class AddPmToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :user, :belongs_to
    add_column :stocks, :user_id, :integer
  end
end
