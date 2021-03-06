# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Customer < ActiveRecord::Base
  has_many :job, dependent: :destroy

  validates :name, presence: :true, uniqueness: true
end
