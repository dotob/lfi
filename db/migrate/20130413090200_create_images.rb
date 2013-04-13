class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :path
      t.string :type
      t.datetime :last_change
      t.datetime :last_visit

      t.timestamps
    end
  end
end
