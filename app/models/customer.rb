class Customer < ActiveRecord::Base
  has_many :job, dependent: :destroy

  validate :name, presence: :true
end
