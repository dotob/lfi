class Image < ActiveRecord::Base
  attr_accessible :last_change, :last_visit, :name, :path, :type
end
