require 'multi_json'
require "net/http"
require "uri"

class OrderItemsLoader
  include Sidekiq::Worker

  def perform(order)
    json_data = get_order_images_json(order.key)
    order_items = MultiJson.load(json_data, :symbolize_keys => true)
    if order_items
      order_items.each do |oi|
        fn = oi[:file_name]
        oi = OrderItem.find_or_initialize_by_file_name(fn)
        oi.images = find_images(fn)
        oi.orders << order
        oi.save
      end
    end
  end

  def find_images(filename)
    fn = File.basename(filename)
    Images.where('name = "?"', fn)
  end

  def get_order_images_json(id)
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders&id=#{id}"))
    response.body
  end
end
