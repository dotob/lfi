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
		add_index :images, :file_name
		add_index :images, :file_type
		add_index :images, :name
		add_index :images, :last_change
		add_index :images, :last_visit
  end
end
