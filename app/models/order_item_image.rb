class OrderItemImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :order_item
end
