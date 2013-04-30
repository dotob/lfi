class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :file_name

      t.timestamps
    end
  end
end
