class Image < ActiveRecord::Base
  has_many :order_item_images
  has_many :order_items, :through => :order_item_images
  attr_accessible :last_change, :last_visit, :name, :path, :file_type, :directory, :file_name

  def get_doubles
    Image.where(name: self.file_name).take(5)
  end
end
