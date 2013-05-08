class CreateCopyTargets < ActiveRecord::Migration
  def change
    create_table :copy_targets do |t|
      t.string :path
      t.integer :prio
      t.boolean :active

      t.timestamps
    end
  end
end
