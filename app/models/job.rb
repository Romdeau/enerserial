# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  job_number  :string(255)
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Job < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  has_many :stock

  attr_accessor :pm_email

  validates :job_number, presence: :true, uniqueness: :true
  validates :customer_id, presence: true

end
