class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value
      t.string :value_type
      t.timestamps null: false
    end
    add_index :settings, :key
  end
end
