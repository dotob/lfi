class Order < ActiveRecord::Base
  has_many :order_items
  attr_accessible :count, :key, :login, :name

  def self.create_from_json(j)
    Rails::logger.debug "Order: create or find order #{j[:id]} - #{j[:name]}"
    o = Order.find_or_initialize_by_key(j[:id])
    o.key = j[:id]
    o.name = j[:name]
    o.login = j[:login]
    o.count = j[:total].to_i
    o.save
  end
end
