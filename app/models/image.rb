class Image < ActiveRecord::Base
  attr_accessible :last_change, :last_visit, :name, :path, :type, :directory, :file_name

  def lookup_or_create(path)
    i = Image.where("path = ?", path) 
    logger.debug 'found this #{i} for path #{path}'
    i.nil? ? Image.new : i
  end
end
