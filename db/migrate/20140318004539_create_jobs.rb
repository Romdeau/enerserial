class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_number
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
