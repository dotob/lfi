class OrderItem < ActiveRecord::Base
  has_many :order_item_images
  has_many :order_contents
  has_many :orders, :through => :order_contents
  has_many :images, :through => :order_item_images
  attr_accessible :file_name

  def get_image_paths
    paths = ""
    unless images.nil?
      images.each do |i|
        paths += i.path
      end
    end
    paths
  end

end
