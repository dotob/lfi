class Order < ActiveRecord::Base
  has_many :order_items
  attr_accessible :count, :key, :login, :name
end
