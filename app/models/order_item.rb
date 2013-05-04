class OrderItem < ActiveRecord::Base
  has_many :orders, :through => :order2orderitems
  has_many :images, :through => :orderitems2images
  attr_accessible :file_name
end
