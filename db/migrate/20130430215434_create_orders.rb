class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :key
      t.string :name
      t.string :login
      t.integer :count

      t.timestamps
    end
  end
end
