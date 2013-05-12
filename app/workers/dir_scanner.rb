class DirScanner
  include Sidekiq::Worker
  sidekiq_options :queue => :dirscanner

  def perform(directory)
    Rails::logger.debug "DirScanner: scanning dir #{directory}"
    # scan for dirs
    Dir.glob("#{directory}/*") do |f|
      if File.directory?(f)
        Rails::logger.debug "defer scanning dir #{f}"
        DirScanner.perform_async(f)
      end
    end
    # scan for files
    Dir.glob("#{directory}/{*.jpg,*.JPG,*.xmp,*.nef,*.NEF,*.tiff,*.tif,*.TIFF,*.TIF,*.psd,*.PSD}") do |f|
      Rails::logger.debug "DirScanner: found #{f}"
      i = Image.find_or_initialize_by_path(f)
      i.file_name = File.basename(f)
      i.path = f
      i.directory = File.dirname(f)
      extension = File.extname(f)
      i.file_type = extension.downcase[1..4]
      i.name = File.basename(f, extension)
      i.last_change = File.mtime(f) 
      i.last_visit = DateTime.now
      begin
        i.save
        Rails::logger.debug "DirScanner: saved file #{i.path}"
      rescue SystemCallError => autsch
        Rails::logger.debug "DirScanner: failed to save file #{i.path} !! this happend: #{autsch}"
      end
    end
  end
end
