class Image < ActiveRecord::Base
  has_many :order_item_images
  has_many :order_items, :through => :order_item_images
  attr_accessible :last_change, :last_visit, :name, :path, :file_type, :directory, :file_name

  def get_doubles
    Image.find_all_by_file_name(self.file_name)[0..5]
  end
end
