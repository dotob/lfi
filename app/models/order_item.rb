class OrderItem < ActiveRecord::Base
  belongs_to :order
  attr_accessible :file_name
end
