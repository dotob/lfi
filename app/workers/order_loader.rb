require 'multi_json'
require "net/http"
require "uri"

class OrderLoader
  include Sidekiq::Worker
  sidekiq_options :queue => :orderloader

  def perform
    Rails::logger.debug "OrderLoader: start updating"
    order_list = get_orders
    order_list.each do |jo|
      Rails::logger.debug "OrderLoader: create or find order #{jo[:id]} - #{jo[:name]}"
      o = Order.create_from_json(jo)
      OrderItemsLoader.perform_async(o.id)
    end
  end
  
  def self.get_orders
    json_data = get_orders_json
    MultiJson.load(json_data, :symbolize_keys => true)
  end

  def self.get_orders_json
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders"))
    response.body
  end
end
