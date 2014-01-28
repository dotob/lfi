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
        already_know_it = Order.exists(jo[:id])
        unless already_know_it
          o = Order.create_from_json(jo)
          Rails::logger.debug "CheckForNewOrders: found new order with id=#{o.id}"
          ct = CopyTarget.where(:prio, 0).first
          if ct
            CopyOrderWorker.perform_async(o.id, ct.path)
            Rails::logger.debug "CheckForNewOrders: started copying order #{o.id} to #{ct.path}"
          else
            Rails::logger.debug "CheckForNewOrders: no copytarget with prio 1 found. did nothing..."
          end
        end
      end
    end
  end
  
  def get_orders_json
    response = Net::HTTP.get_response(URI("http://thalora.com/php/index.php?mode=desktop_get_orders"))
    response.body
  end
end
