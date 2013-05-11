class AddCreatedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :created, :datetime
  end
end
