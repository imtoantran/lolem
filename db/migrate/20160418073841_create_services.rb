class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :excerpt
      t.string :description
      t.float :price
      t.float :price_promotion

      t.timestamps null: false
    end
  end
end