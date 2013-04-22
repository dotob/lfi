class MainController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @scan_paths = ScanPath.all
    @scan_path = ScanPath.new
    @images = Image.order("last_visit DESC").limit(100)
  end

  def start_scanning
    DirScanner.perform_async(ScanPath.first.path)
    redirect_to :action => "index"
  end
end
