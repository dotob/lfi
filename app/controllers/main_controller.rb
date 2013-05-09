class MainController < ApplicationController
  respond_to :html, :xml, :json

  def images
    stats = Sidekiq::Stats.new
    @jobs = stats.queues["dirscanner"]
    @image_count = Image.count
    @images = Image.order("last_visit DESC").limit(100)
  end

  def conf
    @scan_paths = ScanPath.all
    @scan_path = ScanPath.new
    @copy_targets = CopyTarget.all
    @copy_target = CopyTarget.new
  end

  def start_scanning
    for sp in ScanPath.find_all_by_active(true)
      Rails::logger.debug "start scan for #{sp.path}"
      DirScanner.perform_async(sp.path)
      sp.last_visit = DateTime.now
      sp.save
    end
    redirect_to :action => "images"
  end

  def orders
    stats = Sidekiq::Stats.new
    @jobs = stats.queues["orderloader"]
    @order_count = Order.count
    @orders = Order.order("key DESC").limit(20)
    @copy_targets = CopyTarget.order("prio")
  end
  
  def order
    @order = Order.find(params[:id])
  end
  
  def start_updating_orders
    OrderLoader.perform_async
    redirect_to :action => "orders"
  end
  
  def start_updating_order
    OrderItemsLoader.perform_async(params[:id].to_i)
    redirect_to :action => "orders"
  end

  def start_copy_order
    order = Order.find(params[:order_id])
    copy_target = CopyTarget.find(params[:copy_target_id])
    CopyOrderWorker.perform_async(order.id, copy_target.path)
    redirect_to :action => "orders"
  end

  def sidekiq_queue_jobcount
    stats = Sidekiq::Stats.new
    jobs = stats.queues
    respond_with jobs
  end
end
