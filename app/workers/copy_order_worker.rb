require 'fileutils'
class CopyOrderWorker
  include Sidekiq::Worker

  def perform(order_id, copy_target_path)
    Rails::logger.debug "CopyOrderWorker: start to copy order #{order_id} to #{copy_target_path}"
    order = Order.find(order_id)
    for image in order.images
      Rails::logger.debug "CopyOrderWorker: copy image #{image.name}"
      begin
        FileUtils.cp image.path copy_target_path
      rescue SystemCallError => autsch
        Rails::logger.debug "CopyOrderWorker: copy of #{image.path} failed with #{autsch}"
      end
    end
    Rails::logger.debug "CopyOrderWorker: ended to copy order #{order_id} to #{copy_target_path}"
  end
