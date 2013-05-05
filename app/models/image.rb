class Image < ActiveRecord::Base
  has_many :order_items, :through => :order_item_images
  attr_accessible :last_change, :last_visit, :name, :path, :file_type, :directory, :file_name
end
