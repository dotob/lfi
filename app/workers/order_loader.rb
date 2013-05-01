require 'multi_json'
require "net/http"
require "uri"

class OrderLoader
  include Sidekiq::Worker

  def perform
    update_orders
  end

  def update_orders
    json_data = get_orders_json
    order_list = MultiJson.load(json_data, :symbolize_keys => true)
    order_list.each do |jo|
      o = Order.create_from_json(order_list)
      update_order(o)
    end
  end
  
  def update_order(o)
    json_data = get_orders_json(o.key)
    order_items = MultiJson.load(json_data, :symbolize_keys => true)
    order_items.each do |oi|
      oi = OrderItem.find_or_initialize_by_file_name(oi[:file_name])
      oi.save
    end
  end

  def get_orders_json
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders"))
    response.body
  end
  
  def get_order_images_json(id)
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders&id=#{id}"))
    response.body
  end
end
