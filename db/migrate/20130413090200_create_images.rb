class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :file_name
      t.string :path, :limit => 1000
      t.string :directory
      t.string :file_type
      t.datetime :last_change
      t.datetime :last_visit

      t.timestamps
    end

		add_index :images, :path, :unique => true
  end
end
