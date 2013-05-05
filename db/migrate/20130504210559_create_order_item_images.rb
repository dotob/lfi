class CreateOrderItemImages < ActiveRecord::Migration
  def change
    create_table :order_item_images do |t|
        t.references :image
        t.references :order_item
    end
  end
end
