class CreateOrder2OrderItems < ActiveRecord::Migration
  def change
    create_table :order2orderitems do |t|
        t.references :order
        t.references :order_item
    end
  end
end
