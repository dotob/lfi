require 'fileutils'
class CopyOrderWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :copyorderworker

  def perform(order_id, copy_target_path)
    order = Order.find(order_id)
    Rails::logger.debug "CopyOrderWorker: start to copy order #{order_id} with #{order.order_items.count} items to #{copy_target_path}"
    for order_item in order.order_items
      begin
        images = order_item.images
        if images.any?
          first_path = images.first.path
          if File.exists? first_path
            Rails::logger.debug "CopyOrderWorker: copy image #{first_path}"
            FileUtils.cp first_path, copy_target_path
          end
        end
      rescue SystemCallError => autsch
        Rails::logger.debug "CopyOrderWorker: copy of #{first_path} failed with #{autsch}"
      end
    end
    Rails::logger.debug "CopyOrderWorker: ended to copy order #{order_id} to #{copy_target_path}"
  end
end
