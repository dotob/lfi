class ScanPath < ActiveRecord::Base
  attr_accessible :active, :interval, :last_visit, :path
end
