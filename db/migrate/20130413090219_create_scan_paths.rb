class CreateScanPaths < ActiveRecord::Migration
  def change
    create_table :scan_paths do |t|
      t.string :path
      t.integer :interval
      t.boolean :active
      t.datetime :last_visit

      t.timestamps
    end
  end
end
