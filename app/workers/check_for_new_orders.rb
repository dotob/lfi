require 'multi_json'
require "net/http"
require "uri"

class CheckForNewOrders
  include Sidekiq::Worker
  sidekiq_options :queue => :orderloader

  def perform
    Rails::logger.debug "CheckForNewOrders: start updating"
    latest_order = Order.order("id DESC").first
    if latest_order
      order_list = OrderLoader.get_orders
      order_list.each do |jo|
        Rails::logger.debug "CheckForNewOrders: "
        o = Order.create_from_json(jo)
        OrderItemsLoader.perform_async(o.id)
      end
    end
  end
  
  def get_orders_json
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders"))
    response.body
  end
end
