class Order < ActiveRecord::Base
  has_many :stock

  validates :order_number, presence: :true, uniqueness: :true
end
