class DirScanner
  include Sidekiq::Worker

  def perform(directory)
    doit(directory)
  end

  def self.doit(directory)
    Rails::logger.debug 'scanning dir #{directory}'
    # scan for dirs
    Dir.glob('#{directory}/*') do |f|
      DirScanner.doit(f)
    end
    # scan for files
    #Dir.glob('#{directory}/{*.jpg,*.xmp}') do |f|
    Dir.glob('#{directory}/*.*}') do |f|
      i = Image.lookup_or_create
      i.file_name = File.basename(f)
      i.path = f
      i.directory = File.dirname(f)
      i.type = File.extname(f)
      i.name = File.basename(f, i.type)
      i.last_change = File.mtime(f) 
      i.last_visit = DateTime.now
      i.save
      Rails::logger.debug 'found file #{i.path}'
    end
  end
end
