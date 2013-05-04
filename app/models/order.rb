class Order < ActiveRecord::Base
  has_many :order_items, :through => :order2orderitems
  attr_accessible :count, :key, :login, :name

  def self.create_from_json(j)
    Rails::logger.debug "Order: create or find order #{j[:id]} - #{j[:name]}"
    begin
      o = Order.find_or_initialize_by_key(j[:id])
      o.key = j[:id].to_i
      o.name = j[:name]
      o.login = j[:login]
      o.count = j[:total].to_i
      o.save
    rescue SystemCallError => autsch
      Rails::logger.debug "Order: failed to save order #{j[:id]} - #{j[:name]} with error: #{autsch}"
    end
    return o
  end
end
