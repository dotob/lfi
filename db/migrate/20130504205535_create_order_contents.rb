class CreateOrderContents < ActiveRecord::Migration
  def change
    create_table :order_contents do |t|
        t.references :order
        t.references :order_item
    end
  end
end
