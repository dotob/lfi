require 'fileutils'
class OldImageRemover
  include Sidekiq::Worker
  sidekiq_options :queue => :oldimageremover

  def perform
    all_images = Images.all
    Rails::logger.debug "OldImageRemover: start checking existence of all images"
    remove_count = 0
    for image in all_images
      begin
        Rails::logger.debug "OldImageRemover: remove file #{image.path}"
        #FileUtils.remove_file(image.path)
        remove_count += 1
      rescue SystemCallError => autsch
        Rails::logger.debug "OldImageRemover: removal of #{image.path} failed with #{autsch}"
      end
    end
    Rails::logger.debug "OldImageRemover: ended and removed #{remove_count} images"
  end
end
