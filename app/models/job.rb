# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  job_number  :string(255)
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Job < ActiveRecord::Base
  belongs_to :customer
  has_many :stock
end
