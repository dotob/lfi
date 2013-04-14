class DirScanner
				include Sidekiq::Worker
					  
				def perform(directory)
								# scan for dirs
								Dir.glob('{#directory}/*/') do |f|
												DirScanner.perform_async(f)
								end
								# scan for files
								Dir.glob('{#directory}/{*.jpg,*.xmp}') do |f|
												i = Image.lookup_or_create
												i.file_name = File.basename(f)
												i.path = f
												i.directory = File.dirname(f)
												i.type = File.extname(f)
												i.name = File.basename(f, i.type)
												i.last_change = File.mtime(f) 
												i.last_visit = DateTime.now
								end
				end
end
