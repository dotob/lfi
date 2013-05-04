class MainController < ApplicationController
  respond_to :html, :xml, :json

  def images
    stats = Sidekiq::Stats.new
    @image_count = Image.count
    @jobs = stats.enqueued
    @images = Image.order("last_visit DESC").limit(100)
  end

  def conf
    @scan_paths = ScanPath.all
    @scan_path = ScanPath.new
  end

  def start_scanning
    for sp in ScanPath.find_all_by_active(true)
      DirScanner.perform_async(sp)
      sp.last_visit = DateTime.now
      sp.save
    end
    redirect_to :action => "index"
  end

  def orders
    @order_count = Order.count
    @orders = Order.order("key DESC").limit(20)
  end
  
  def start_updating_orders
    OrderLoader.perform_async
    redirect_to :action => "orders"
  end
end
