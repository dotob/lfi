class CreateOrderItems2Image < ActiveRecord::Migration
  def change
    create_table :orderitems2image do |t|
        t.references :image
        t.references :order_item
    end
  end
end
