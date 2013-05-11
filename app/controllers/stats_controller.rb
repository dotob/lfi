class StatsController < ApplicationController
  respond_to :html

  def index
    # images stats
    @all_images_count = Image.count
    @jpg_count = Image.where("file_type = 'jpg'").count
    @tif_count = Image.where("file_type = 'tif'").count
    @nef_count = Image.where("file_type = 'nef'").count
    @xmp_count = Image.where("file_type = 'xmp'").count
    @psd_count = Image.where("file_type = 'psd'").count
    @doubles_count = Image.select("file_name").group("file_name").having("count() > 1")
    @jpg_percentage = @jpg_count /( @all_images_count / 100)
    @tif_percentage = @tif_count /( @all_images_count / 100)
    @nef_percentage = @nef_count /( @all_images_count / 100)
    @xmp_percentage = @xmp_count /( @all_images_count / 100)
    @psd_percentage = @psd_count /( @all_images_count / 100)
    @doubles_percentage = Image.select("file_name").group("file_name").having("count() > 1")

    # orders stats
    @all_orders_count = Order.count
  end
end

