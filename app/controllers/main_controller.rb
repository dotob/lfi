class MainController < ApplicationController
  respond_to :html, :xml, :json

  def index
    stats = Sidekiq::Stats.new
    @jobs = stats.enqueued
    @images = Image.order("last_visit DESC").limit(100)
  end

  def conf
    @scan_paths = ScanPath.all
    @scan_path = ScanPath.new
  end

  def start_scanning
    for sp in ScanPath.find_all_by_active(true)
      DirScanner.perform_async(ScanPath.first.path)
      sp.last_visit = DateTime.Now
      sp.save
    end
    redirect_to :action => "index"
  end
end
