require 'fileutils'
class CopyOrderWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :copyorderworker

  def perform(order_id, copy_target_path)
    order = Order.find(order_id)
    copy_to = File.join copy_target_path, order.key
    FileUtils.mkdir_p copy_to
    Rails::logger.debug "CopyOrderWorker: start to copy order >#{order_id}< with #{order.order_items.count} items to #{copy_to}"
    copy_count = 0
    for order_item in order.order_items
      begin
        images = order_item.images
        for image in images
          first_path = image.path
          if File.exists? first_path
            Rails::logger.debug "CopyOrderWorker: copy image from #{first_path}"
            FileUtils.cp first_path, copy_to
            copy_count += 1
          end
        end
      rescue SystemCallError => autsch
        Rails::logger.debug "CopyOrderWorker: copy of #{first_path} failed with #{autsch}"
      end
    end
    Rails::logger.debug "CopyOrderWorker: ended to copy #{copy_count} images of  order >#{order_id}< to #{copy_to}"
  end
end
