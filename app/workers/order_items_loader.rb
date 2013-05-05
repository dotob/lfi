require 'multi_json'
require "net/http"
require "uri"

class OrderItemsLoader
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    Rails::logger.debug "OrderItemsLoader: start loading order #{order} with key #{order.key}"
    json_data = get_order_images_json(order.key)
    order_items = MultiJson.load(json_data, :symbolize_keys => true)
    if order_items
      order_items.each do |oi|
        begin
          fn = oi[:filename_orig]
          oi = OrderItem.find_or_initialize_by_file_name(fn)
          oi.orders << order
          oi.images = find_images(fn)
          oi.save
        rescue SystemCallError => autsch
          Rails::logger.debug "OrderItemsLoader: failed to save orderitem #{fn} with error: #{autsch}"
        end
      end
    end
  end

  def find_images(filename)
    unless filename.nil?
      fn = File.basename(filename)
      Image.where('name = "?"', fn)
    end
  end

  def get_order_images_json(id)
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders&id=#{id}"))
    response.body
  end
end