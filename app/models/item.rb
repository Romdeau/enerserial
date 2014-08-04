class Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :stock
end
