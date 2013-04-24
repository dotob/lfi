class Image < ActiveRecord::Base
  attr_accessible :last_change, :last_visit, :name, :path, :file_type, :directory, :file_name
end
